// Default empty project template
import bb.cascades 1.0

// creates one page with a label
Page {
    Container {
        layout: DockLayout {

        }        

        ForeignWindowControl {
            objectName: "windowControl"
            windowId: "cameraViewfinder"
        }

        Label {
            objectName: "status"
            textStyle.color: Color.White
        }
    }
}

