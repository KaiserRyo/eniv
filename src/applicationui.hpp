// Default empty project template
#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/cascades/ForeignWindowControl>
#include <bb/cascades/TouchEvent>
#include <bb/cascades/Label>

#include <camera/camera_api.h>

using namespace bb::cascades;

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI : public QObject
{
    Q_OBJECT

public slots:
    void onWindowAttached(screen_window_t win, const QString &group, const QString &id);
    void onTouch(bb::cascades::TouchEvent* event);

public:
    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() {}

private:
    Label* lblStatus;
    ForeignWindowControl *mViewfinderWindow;
    camera_handle_t mCameraHandle;
    camera_unit_t mCameraUnit;
    int mVideoFileDescriptor;

    int createViewfinder(camera_unit_t cameraUnit, const QString &group, const QString &id);

    void onStartRecording();
    void onStopRecording();

    void cameraStatus(camera_handle_t, camera_devstatus_t, uint16_t, void*);
};

void writeEncodedBuffer(camera_handle_t, camera_buffer_t*, void*);
#endif /* ApplicationUI_HPP_ */
