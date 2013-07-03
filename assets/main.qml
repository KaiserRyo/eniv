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
        content: Explore {
        }
    }
    Tab {
        title: 'Activity'
        content: Activity {
        }
    }
    Tab {
        title: 'Profile'
        content: Profile {
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
