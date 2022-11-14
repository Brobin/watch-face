using Toybox.Application;
using Toybox.Lang;
using Toybox.WatchUi;

class AresApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new AresView() ];
    }

}

function getApp() {
    return Application.getApp();
}
