<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>

    <title>Exam Result | ExamShield AI</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>

        body{
            background:#f4f7fc;
        }

        .result-container{
            max-width:1200px;
            margin:40px auto;
        }

        .score-card{
            background:white;
            border-radius:20px;
            padding:40px;
            text-align:center;
            box-shadow:0 8px 25px rgba(0,0,0,.08);
        }

        .score{
            font-size:80px;
            font-weight:700;
            color:#22c55e;
        }

        .summary-card{
            background:white;
            border-radius:20px;
            padding:25px;
            box-shadow:0 8px 25px rgba(0,0,0,.08);
            text-align:center;
        }

        .summary-card h2{
            color:#2563eb;
            font-weight:700;
        }

        .chart-card{
            background:white;
            border-radius:20px;
            padding:25px;
            margin-top:25px;
            box-shadow:0 8px 25px rgba(0,0,0,.08);
        }

    </style>

</head>

<body>

<div class="container result-container">

    <div class="score-card">

        <i class="fas fa-award fa-4x text-warning"></i>

        <h1 class="mt-3">
            Exam Completed Successfully
        </h1>

        <div class="score">
            92%
        </div>

        <h3 class="text-success">
            PASS
        </h3>

        <p>
            Congratulations! You performed excellently.
        </p>

        <button class="btn btn-primary">
            Download PDF
        </button>

        <button class="btn btn-success">
            Download Certificate
        </button>

    </div>

    <div class="row mt-4">

        <div class="col-md-3">

            <div class="summary-card">

                <h2>20</h2>
                <p>Total Questions</p>

            </div>

        </div>

        <div class="col-md-3">

            <div class="summary-card">

                <h2>18</h2>
                <p>Correct</p>

            </div>

        </div>

        <div class="col-md-3">

            <div class="summary-card">

                <h2>2</h2>
                <p>Wrong</p>

            </div>

        </div>

        <div class="col-md-3">

            <div class="summary-card">

                <h2>60m</h2>
                <p>Time Used</p>

            </div>

        </div>

    </div>

    <div class="chart-card">

        <h4 class="mb-4">
            Performance Analysis
        </h4>

        <canvas id="resultChart"></canvas>

    </div>

</div>

<script>

const ctx =
document.getElementById('resultChart');

new Chart(ctx, {

    type: 'bar',

    data: {

        labels: [
            'Correct',
            'Wrong'
        ],

        datasets: [{

            label: 'Performance',

            data: [
                18,
                2
            ]

        }]
    }
});

</script>

</body>
</html>