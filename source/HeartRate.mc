using Toybox.Activity;
using Toybox.ActivityMonitor;
using Toybox.Graphics;
using Toybox.WatchUi;

class HeartRate extends WatchUi.Drawable {
    var iconFont = WatchUi.loadResource(Rez.Fonts.Icons);
    var textFont = WatchUi.loadResource(Rez.Fonts.QuanticoSmall);

    var showCalories  = true;

    function initialize(options) {
        Drawable.initialize(options);
    }

    function getHeartRateText() {
        var heartRate = Activity.Info.currentHeartRate;
        var heartRateText = "--";
        
        if(heartRate == null) {
            var heartrateIterator = ActivityMonitor.getHeartRateHistory(1, true);
            heartRate = heartrateIterator.next().heartRate;
        }

        if (heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
            heartRateText = heartRate.format("%d");
        }

        return heartRateText;
    }

    function getStepsText() {
        var steps = ActivityMonitor.getInfo().steps;
        var stepsText = "--";
        if (steps != null) {
            stepsText = steps.format("%d");
        }
        return stepsText;
    }

    function getCaloriesText() {
        var calories = ActivityMonitor.getInfo().calories;
        var caloriesText = "--";
        if (calories != null) {
            caloriesText = calories.format("%d");
        }
        return caloriesText;
    }

    function draw(dc) {
        var x = dc.getWidth();
        var y = dc.getHeight() * .2;

        var hrText = getHeartRateText();
        var hrIcon = "l";
        var hrTextDimensions = dc.getTextDimensions(hrText, textFont);
        var hrIconDimensions = dc.getTextDimensions(hrIcon, iconFont);

        // Every 5 seconds, swap between showing caloreies and steps
        var time = System.getClockTime();
        if (time.sec % 5 == 0) {
            showCalories = !showCalories;
        }
    
        var secondaryText = showCalories ? getCaloriesText() : getStepsText();
        var secondaryIcon = showCalories ? "X" : "Å";
        
        var secondaryTextDimensions = dc.getTextDimensions(secondaryText, textFont);
        var secondaryIconDimensions = dc.getTextDimensions(secondaryIcon, iconFont);

        var width = hrIconDimensions[0] + hrTextDimensions[0] + secondaryIconDimensions[0] + secondaryTextDimensions[0] + 12;

        var hrIconStart = (x - width) / 2;
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(hrIconStart, y, iconFont, hrIcon, Graphics.TEXT_JUSTIFY_LEFT);

        var hrTextStart = hrIconStart + hrIconDimensions[0] + 4;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(hrTextStart, y, textFont, hrText, Graphics.TEXT_JUSTIFY_LEFT);

        var secondaryIconStart = hrTextStart + hrTextDimensions[0] + 4;
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(secondaryIconStart, y, iconFont, secondaryIcon, Graphics.TEXT_JUSTIFY_LEFT);

        var secondaryTextStart = secondaryIconStart + secondaryIconDimensions[0] + 4;
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(secondaryTextStart, y, textFont, secondaryText, Graphics.TEXT_JUSTIFY_LEFT);
    }
}
