using Toybox.WatchUi;

class Battery extends WatchUi.Drawable {
    var battery;

    function initialize(options) {
        Drawable.initialize(options);
    }

    function setBattery(batteryPct) {
        battery = batteryPct;
    }

    function draw(dc) {
        var width = 32;
        var height = 16;
        var xStart = (dc.getWidth() - width) / 2;
        var yStart = 15;
        
        // Draw battery container
        dc.setPenWidth(1);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(xStart, yStart, width, height);

        // Draw battery end
        var xKnob = xStart + 32 + 1;
        dc.drawLine(xKnob, yStart + 4, xKnob, yStart + 12);

        if (battery >= 50) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        } else if (battery >= 30) {
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        } else {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        }
        dc.fillRectangle(xStart + 1, yStart + 1, (width - 2) * battery / 100, height - 2);
    }
}
