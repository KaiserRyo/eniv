import bb.cascades 1.0

Page {
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {}
        Container {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
	        ImageView {
	            imageSource: "asset:///img/sad.png"
	            horizontalAlignment: HorizontalAlignment.Center
	        }
	        Label {
	            text: 'No activity'
	            horizontalAlignment: HorizontalAlignment.Center
	            textStyle.base: SystemDefaults.TextStyles.BigText
	            textStyle.color: Color.create('#ffdadad4')
	        }
	    }
    }
}
