document.addEventListener('turbolinks:load', () => {
    
    // カロリーの自動計算処理
    $('#newProtein, #newFat, #newCarbo').change(function () {
        var p = $('#newProtein').val();
        var f = $('#newFat').val();
        var c = $('#newCarbo').val();
        var protein = parseInt(p);
        var fat = parseInt(f);
        var carbo = parseInt(c);
        var calorie = (protein + carbo) * 4 + fat * 9;
        $('#newCalorie').val(calorie);
    }
    );

    // カレンダーの表示
    const TODAY = new Date(new Date().setHours(0, 0, 0, 0))
    // カレンダーの日本語化
    flatpickr.localize(flatpickr.l10ns.ja)
    var calendar = flatpickr('#meal-calendar, #new-meal-carendar', {
        disableMobile: true,
        // defaultDate: TODAY,
        maxDate: TODAY,
    })

    // console.log("判別しました");

    // $('#meal-calendar').change(function () {
    //     console.log("変わりました")

    // })
})