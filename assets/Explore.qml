import bb.cascades 1.0

Page {
    ScrollView {
        content:  Container {
	        layout: StackLayout {
	            orientation: LayoutOrientation.TopToBottom
	        }
	        Container {
	            leftPadding: 2
	            rightPadding: 2
	            topPadding: 2
	            TextField {
	                hintText: "Search people or tags"
	            }
	        }	
	        ListLikeButton {
	            title: "Editor's picks"
	        }
	        ListLikeButton {
	            title: "Popular Now"
	        }
	        ListView {
	            horizontalAlignment: HorizontalAlignment.Center
	            preferredWidth: 640
	            preferredHeight: 460
	            topPadding: 20
	            dataModel: XmlDataModel {
	                source: "asset:///data/explore2.xml"
	            }
	            layout: GridListLayout {
	                columnCount: 3
	                verticalCellSpacing: 20 
	            }
	            listItemComponents: [
	                ListItemComponent {
	                    type: "item"
	                    Container {
		                    preferredWidth: 200
		                    preferredHeight: 200
		                    maxHeight: 200
		                    maxWidth: 200
		                    background: Color.create(ListItemData.color)
		                    horizontalAlignment: HorizontalAlignment.Center
		                    verticalAlignment: VerticalAlignment.Center
		                    layout: StackLayout {
	                      		orientation: LayoutOrientation.TopToBottom
	                      	}
		                    topPadding: 20
		                    ImageView {
		                        imageSource: "asset:///img/" + ListItemData.icon
		                        horizontalAlignment: HorizontalAlignment.Center
		                        preferredWidth: 100
		                        preferredHeight: 100
		                    }
		                    Label {
		                        text: ListItemData.title
	                            horizontalAlignment: HorizontalAlignment.Center
	                            textStyle.base: SystemDefaults.TextStyles.TitleText
	                            textStyle.color: Color.White
	                            textStyle.fontWeight: FontWeight.W500
	                        }
		                }
	                }
	            ]
	            bottomMargin: 20
	        }
	        ListView {
	            dataModel: XmlDataModel {
	                source: "asset:///data/explore.xml"
	            }
	        }
	    }
	}
}
