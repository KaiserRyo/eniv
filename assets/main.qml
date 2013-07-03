import bb.cascades 1.0

TabbedPane {
    id: tabbedPane
    showTabsOnActionBar: false
    Tab {
        title: 'Home'
        content: Home {} 
    }
    Tab {
        title: 'Explore'
        content: Home {
        }
    }
    Tab {
        title: 'Activity'
        content: Home {
        }
    }
    Tab {
        title: 'Profile'
        content: Home {
        }
    }
    Menu.definition: MenuDefinition {
        actions: [
            ActionItem {
                title: "Settings"
            }
        ]
    }
}
