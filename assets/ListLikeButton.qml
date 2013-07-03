import bb.cascades 1.0

Container {
    property alias title: titleLabel.text
    layout: DockLayout {
    }
    preferredHeight: 120
    Label {
        id: titleLabel
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        textStyle.base: SystemDefaults.TextStyles.TitleText
    }
    ImageView {
        imageSource: "asset:///img/arrowright.png"
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
    }
    Divider {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Bottom
    }
}