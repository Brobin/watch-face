using Toybox.WatchUi;

const BATTERY_RED = "0xEF5350".toFloat();
const BATTERY_BLUE = "0x3399CC".toFloat();
const BATTERY_GREEN = "0x4CAF50".toFloat();
const BATTERY_YELLOW = "0xFF9900".toFloat();

class Battery extends WatchUi.Drawable {

    function initialize(options) {
        Drawable.initialize(options);
    }

    function draw(dc) {
        var battery = System.getSystemStats().battery;
        var charging = System.getSystemStats().charging;

        var width = 32;
        var height = 16;
        var xStart = (dc.getWidth() - width) / 2;
        var yStart = 20;
        
        // Draw battery container
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(xStart, yStart, width, height);

        // Draw battery end
        var xKnob = xStart + 32 + 1;
        dc.drawLine(xKnob, yStart + 4, xKnob, yStart + 12);

        // // Fill battery level
        if(charging) {
            dc.setColor(BATTERY_BLUE, Graphics.COLOR_TRANSPARENT);
        } else if (battery >= 50) {
            dc.setColor(BATTERY_GREEN, Graphics.COLOR_TRANSPARENT);
        } else if (battery >= 30) {
            dc.setColor(BATTERY_YELLOW, Graphics.COLOR_TRANSPARENT);
        } else {
            dc.setColor(BATTERY_RED, Graphics.COLOR_TRANSPARENT);
        }
        dc.fillRectangle(xStart + 1, yStart + 1, (width - 2) * battery / 100, height - 2);
    }
}
