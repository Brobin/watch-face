using Toybox.Activity;
using Toybox.ActivityMonitor;
using Toybox.Application;
using Toybox.WatchUi;

using Toybox.Time.Gregorian as Date;

class AresView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
    }
}