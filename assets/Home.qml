import bb.cascades 1.0

Page {
    ListView {
        dataModel: XmlDataModel {
            source: "asset:///data/home.xml"
        }
        listItemComponents: [
            ListItemComponent {
                type: "post"
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    preferredWidth: 8000
                    horizontalAlignment: HorizontalAlignment.Center
                    topPadding: 20
                    ForeignWindowControl {
                    	preferredWidth: 600
                    	preferredHeight: 600
                    	horizontalAlignment: HorizontalAlignment.Center
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        preferredWidth: 600
                        horizontalAlignment: HorizontalAlignment.Center
                        Container {
                            topPadding: 20
                            topMargin: 20
                            layout: DockLayout {}
                            ImageView {
                                imageSource: ListItemData.userimage
                                maxWidth: 120
                                maxHeight: 120
                                scalingMethod: ScalingMethod.AspectFill
                            }
                        }
                        Container {
                            topPadding: 20
                            topMargin: 20
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            Container {
                                layout: DockLayout {}
                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    text: ListItemData.username
	                                textStyle.base: SystemDefaults.TextStyles.TitleText
	                                textStyle.color: Color.create(0, 163/255, 118/255, 1.0)
	                                textStyle.fontWeight: FontWeight.W500
	                                horizontalAlignment: HorizontalAlignment.Left
	                            }
                                Label {
                                    text: ListItemData.when
                                    textStyle.color: Color.create(0.8, 0.8, 0.8, 1.0)
                                    textStyle.base: SystemDefaults.TextStyles.SmallText
                                    textStyle.fontSize: FontSize.Small
                                    horizontalAlignment: HorizontalAlignment.Right
                                    verticalAlignment: VerticalAlignment.Center
                                }
	                        }
                            Label {
                                text: ListItemData.description
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            }
                            Divider {}
                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
		                        Button {
		                            text: "Like"
		                            preferredWidth: preferredHeight
		                        }
		                        Button {
		                            text: "Comment"
                                    preferredWidth: preferredHeight
                                }
		                    }
                        }
                    }
                    Divider {}
                }
            }
        ]
    }
    actions: [
        ActionItem {
            title: 'Camera'
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]
}
