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

    const convertDate = (date) => new Date(new Date(date).setHours(0, 0, 0, 0))
    // カレンダーの表示
    const TODAY = convertDate(new Date())
    const A_WEEK_AGO = new Date(TODAY.getFullYear(), TODAY.getMonth(), TODAY.getDate() - 6)
    
    // カレンダーの日本語化
    flatpickr.localize(flatpickr.l10ns.ja)
    var calendar = flatpickr('#meal-calendar, #new-meal-carendar', {
        disableMobile: true,
        // defaultDate: TODAY,
        maxDate: TODAY,
    })

    // グラフを書く場所を取得
    const chartCalorieContext = document.getElementById('calorieChart').getContext('2d');
    const drawGraph = (from, to) => {
        // from から to までの期間のデータに絞る
        let records = gon.calorie_records.filter((record) => {
            let date = convertDate(record.date)
            return from <= date && date <= to
        })

        let dates = records.map((record) => {
            // 横軸のラベル表示は簡潔にしたいので，
            // 日付 2020-01-08 を 1/8 のような形式に変換する
            return record.date.replace(/^\d+-0*(\d+)-0*(\d+)$/, '$1/$2')
        })

        // 体重のみのデータを作成
        let calories = records.map((record) => record.calorie)

        let weightData = {
            labels: dates,
            datasets: [{
                label: 'カロリー(kcal)',
                data: calories,
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1,
                spanGaps: true
            }]
        }

        let weightOption = {
            tooltips: {
                callbacks: {
                    // ホバー（スマホならタップ）時のラベル表示を変更
                    title: function (tooltipItems) {
                        return tooltipItems[0].xLabel.replace(/^(\d+).(\d+)$/, ' $1 月 $2 日')
                    },
                    label: function (tooltipItem) {
                        return 'カロリー: ' + tooltipItem.yLabel + 'kcal'
                    }
                }
            }
        }

        new Chart(chartCalorieContext, {
            type: 'line',
            data: weightData,
            options: weightOption
        })
    }
    drawGraph(A_WEEK_AGO, TODAY)
})