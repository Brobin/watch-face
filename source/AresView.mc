using Toybox.Activity;
using Toybox.ActivityMonitor;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
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
        setBatteryDisplay();
        setHeartRateDisplay();
        setTimeDisplay();
        setDateDisplay();

        View.onUpdate(dc);
    }

    private function setBatteryDisplay() {
        var battery = System.getSystemStats().battery;
        var charging = System.getSystemStats().charging;
        var character = "";

        if (charging) {
            character = "0";
        } else if (battery >= 80) {
            character = "/";
        } else if (battery >= 50) {
            character = ".";
        } else if (battery >= 20) {
            character = "-";
        } else {
            character = ",";
        }

        var batteryDisplay = View.findDrawableById("BatteryDisplay");
        batteryDisplay.setText(character);
    }

    private function setHeartRateDisplay() {
        var heartRate = "";

        if (ActivityMonitor has : getHeartRateHistory) {
        var heartrateIterator = ActivityMonitor.getHeartRateHistory(1, true);
        var currentHeartrate = heartrateIterator.next().heartRate;
        if (currentHeartrate == ActivityMonitor.INVALID_HR_SAMPLE) {
            heartRate = "";
        } else {
            heartRate = currentHeartrate.format("%d");
        }
        }

        var heartrateDisplay = View.findDrawableById("HeartRateDisplay");
        heartrateDisplay.setText(heartRate);
    }

    private function setTimeDisplay() {
        var time = System.getClockTime();
        var hours = time.hour;
        if (!System.getDeviceSettings().is24Hour) {
        if (hours > 12) {
            hours = hours - 12;
        } else if (hours == 0) {
            hours = 12;
        }
        }
        var hour = View.findDrawableById("HourDisplay");
        hour.setText(hours.format("%02d"));

        var colon = View.findDrawableById("ColonDisplay");
        colon.setText(":");

        var minute = View.findDrawableById("MinuteDisplay");
        minute.setText(time.min.format("%02d"));
    }

    private function setDateDisplay() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_LONG);
        var dateString = Lang.format("$1$, $2$ $3$", [ date.day_of_week, date.month, date.day ]);
        var dateDisplay = View.findDrawableById("DateDisplay");
        dateDisplay.setText(dateString);
    }

}