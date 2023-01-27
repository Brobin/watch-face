using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;

class Time extends WatchUi.Drawable {

    function initialize(options) {
        Drawable.initialize(options);
    }

    function draw(dc) {
        var time = System.getClockTime();
        var hours = time.hour;
        var minutes = time.min;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            } else if (hours == 0) {
                hours = 12;
            }
        }

        var hourText = hours.toString();
        if (getApp().getProperty("PadHour")) {
            hourText = hours.format("%02d");
        }

        var colonText = ":";
        var minutesText = minutes.format("%02d");

        var font = WatchUi.loadResource(Rez.Fonts.QuanticoBold);

        var hourDimensions = dc.getTextDimensions(hourText, font);
        var colonWidth = dc.getTextWidthInPixels(colonText, font);
        var minutesWidth = dc.getTextWidthInPixels(minutesText, font);

        var totalWidth = hourDimensions[0] + colonWidth + minutesWidth;
    
        var height = (dc.getHeight() - hourDimensions[1]) / 2;
        var hourStart = (dc.getWidth() - totalWidth) / 2;
        var colonStart = hourStart + hourDimensions[0];
        var minutesStart = colonStart + colonWidth;

        dc.setColor(getApp().getProperty("HourColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(hourStart, height, font, hourText, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(colonStart, height, font, colonText, Graphics.TEXT_JUSTIFY_LEFT);

        dc.setColor(getApp().getProperty("MinuteColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(minutesStart, height, font, minutesText, Graphics.TEXT_JUSTIFY_LEFT);
    }
}
