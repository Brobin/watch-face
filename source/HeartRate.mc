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
        var y = dc.getHeight();

        var iconFont = WatchUi.loadResource(Rez.Fonts.Icons);
        var textFont = WatchUi.loadResource(Rez.Fonts.AldrichSmall);

        var iconDimensions = dc.getTextDimensions("l", iconFont);
        var textDimensions = dc.getTextDimensions(heartRateString, textFont);

        var width = iconDimensions[0] + textDimensions[0] + 4;

        var iconStart = (x - width) / 2;
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(iconStart, y *.2, iconFont, "l", Graphics.TEXT_JUSTIFY_LEFT);

        var textStart = iconStart + iconDimensions[0] + 4;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(textStart, y *.21, textFont, heartRateString, Graphics.TEXT_JUSTIFY_LEFT);

    }
}
