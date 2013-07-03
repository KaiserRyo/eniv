// Default empty project template
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LayoutProperties>
#include <bb/cascades/WindowProperty>
#include <bb/cascades/TouchType>

#include <camera/camera_api.h>
#include <screen/screen.h>
#include <bps/soundplayer.h>
#include <unistd.h>
#include <libgen.h>

#include "applicationui.hpp"

using namespace bb::cascades;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) : QObject(app), mCameraHandle(CAMERA_HANDLE_INVALID)
{
    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    // create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    lblStatus = root->findChild<Label*>("status");

    mViewfinderWindow = root->findChild<ForeignWindowControl*>("windowControl");
    mViewfinderWindow->setUpdatedProperties(WindowProperty::Position | WindowProperty::Size | WindowProperty::Visible);

    connect(mViewfinderWindow, SIGNAL(windowAttached(screen_window_t, const QString &, const QString &)), this, SLOT(onWindowAttached(screen_window_t, const QString &,const QString &)));
    connect(mViewfinderWindow, SIGNAL(touch(bb::cascades::TouchEvent*)), this, SLOT(onTouch(bb::cascades::TouchEvent*)));

    app->setScene(root);

    if(this->mViewfinderWindow) {
        if(createViewfinder(CAMERA_UNIT_REAR,
                    this->mViewfinderWindow->windowGroup().toStdString().c_str(),
                    this->mViewfinderWindow->windowId().toStdString().c_str()) == EOK) {
            qDebug() << "Success";
        }
        else {
            qDebug() << "Fail";
        }
    }
}

void ApplicationUI::onTouch(bb::cascades::TouchEvent* event) {
    switch(event->touchType()) {
        case TouchType::Down:
            this->onStartRecording();
            break;
        case TouchType::Up:
            this->onStopRecording();
            break;
    }
}

void ApplicationUI::onWindowAttached(screen_window_t win, const QString &group, const QString &id)
{
    qDebug() << "onWindowAttached: " << win << ", " << group << ", " << id;

    int i = (mCameraUnit == CAMERA_UNIT_FRONT);
    screen_set_window_property_iv(win, SCREEN_PROPERTY_MIRROR, &i);
    // put the viewfinder window behind the cascades window
    i = -1;
    screen_set_window_property_iv(win, SCREEN_PROPERTY_ZORDER, &i);
    screen_context_t screen_ctx;
    screen_get_window_property_pv(win, SCREEN_PROPERTY_CONTEXT, (void **)&screen_ctx);
    screen_flush_context(screen_ctx, 0);
}

int ApplicationUI::createViewfinder(camera_unit_t cameraUnit, const QString &group, const QString &id)
{
    qDebug() << "createViewfinder";
    if (mCameraHandle != CAMERA_HANDLE_INVALID) {
        qDebug() << "camera already running";
        return EBUSY;
    }
    mCameraUnit = cameraUnit;
    if (camera_open(mCameraUnit,
                    CAMERA_MODE_RW | CAMERA_MODE_ROLL,
                    &mCameraHandle) != CAMERA_EOK) {
        qDebug() << "could not open camera";
        return EIO;
    }
    qDebug() << "camera opened";
    if (camera_set_videovf_property(mCameraHandle,
                                    CAMERA_IMGPROP_WIN_GROUPID, group.toStdString().c_str(),
                                    CAMERA_IMGPROP_WIN_ID, id.toStdString().c_str()) == CAMERA_EOK) {
        qDebug() << "viewfinder configured";
        if (camera_start_video_viewfinder(mCameraHandle, NULL, NULL, NULL) == CAMERA_EOK) {
            qDebug() << "viewfinder started";

            return EOK;
        }
    }
    qDebug() << "couldn't start viewfinder";
    camera_close(mCameraHandle);
    mCameraHandle = CAMERA_HANDLE_INVALID;
    return EIO;
}

void ApplicationUI::onStartRecording() {
    qDebug() << "start recording";

    char filename[CAMERA_ROLL_NAMELEN];
    if (camera_roll_open_video(mCameraHandle,
                               &mVideoFileDescriptor,
                               filename,
                               sizeof(filename),
                               CAMERA_ROLL_VIDEO_FMT_DEFAULT) == CAMERA_EOK) {
        qDebug() << "opened " << filename;
        if (camera_start_video(mCameraHandle,
                               filename,
                               NULL,
                               NULL,
                               NULL) == CAMERA_EOK) {
            lblStatus->setText("Recording...");
            lblStatus->setVisible(true);
            return;
        }
        qDebug() << "failed to start recording";
        camera_roll_close_video(mVideoFileDescriptor);
        mVideoFileDescriptor = -1;
    }
}

void ApplicationUI::onStopRecording() {
    qDebug() << "stopped recording";

    camera_stop_video(mCameraHandle);
    camera_roll_close_video(mVideoFileDescriptor);

    lblStatus->setVisible(false);
}
