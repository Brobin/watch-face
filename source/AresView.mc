using Toybox.Activity;
using Toybox.ActivityMonitor;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.Time;
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
        setDateDisplay();

        View.onUpdate(dc);
    }

    private function setBatteryDisplay() {
        var battery = View.findDrawableById("Battery");
        battery.setBattery(System.getSystemStats().battery);
    }

    private function setHeartRateDisplay() {
        var heartRate = Activity.Info.currentHeartRate;
        var heartRateString = "--";

        if(heartRate == null) {
            var heartrateIterator = ActivityMonitor.getHeartRateHistory(1, true);
            heartRate = heartrateIterator.next().heartRate;
        }

        if (heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
            heartRateString = heartRate.format("%d");
        }

        var heartrateDisplay = View.findDrawableById("HeartRateDisplay");
        heartrateDisplay.setText(heartRateString);

        var heartrateIcon = View.findDrawableById("HeartRateIcon");
        heartrateIcon.setText("m");
    }

    private function setDateDisplay() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_LONG);
        var dateString;
        if (getApp().getProperty("HideMonth")) {
            dateString = Lang.format("$1$ $2$", [ date.day_of_week, date.day ]);
        } else {
            dateString = Lang.format("$1$, $2$ $3$", [ date.day_of_week, date.month, date.day ]);
        }
        var dateDisplay = View.findDrawableById("DateDisplay");
        dateDisplay.setColor(getApp().getProperty("DateColor"));
        dateDisplay.setText(dateString);
    }

}