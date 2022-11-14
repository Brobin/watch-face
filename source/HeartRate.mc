using Toybox.Activity;
using Toybox.ActivityMonitor;
using Toybox.Graphics;
using Toybox.WatchUi;

class HeartRate extends WatchUi.Drawable {

    function initialize(options) {
        Drawable.initialize(options);
    }

    function draw(dc) {
        var heartRate = Activity.Info.currentHeartRate;
        var heartRateString = "--";

        if(heartRate == null) {
            var heartrateIterator = ActivityMonitor.getHeartRateHistory(1, true);
            heartRate = heartrateIterator.next().heartRate;
        }

        if (heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
            heartRateString = heartRate.format("%d");
        }

        var x = dc.getWidth();
        var y = dc.getHeight() * .2;

        var iconFont = WatchUi.loadResource(Rez.Fonts.Icons);
        var textFont = WatchUi.loadResource(Rez.Fonts.ExoSmall);

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x * .48, y, iconFont, "l", Graphics.TEXT_JUSTIFY_RIGHT);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x * .52, y, textFont, heartRateString, Graphics.TEXT_JUSTIFY_LEFT);

    }
}
