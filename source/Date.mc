using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Time;
using Toybox.WatchUi;
using Toybox.Time.Gregorian as Date;

class Date extends WatchUi.Drawable {

    function initialize(options) {
        Drawable.initialize(options);
    }

    function draw(dc) {
        var date = Date.info(Time.now(), Time.FORMAT_LONG);
    
        var formatString = "$1$, $2$ $3$";
        if (getApp().getProperty("HideMonth")) {
            formatString = "$1$ $3$";
        }

        var x = dc.getWidth() / 2;
        var y = dc.getHeight() * .7;
        var font = WatchUi.loadResource(Rez.Fonts.QuanticoSmall);
        var text = Lang.format(formatString, [date.day_of_week, date.month, date.day]);

        dc.setColor(getApp().getProperty("DateColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, font, text, Graphics.TEXT_JUSTIFY_CENTER);
    }
}
