<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.examshield.model.Question" %>

<%
List<Question> questions =
(List<Question>) request.getAttribute("questions");
%>
<!DOCTYPE html>
<html>
<head>

    <title>Online Examination | ExamShield AI</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="css/style.css">

    <style>

        body{
            background:#f4f7fc;
        }

        .exam-header{
            background:white;
            padding:15px 30px;
            box-shadow:0 2px 15px rgba(0,0,0,.08);
            display:flex;
            justify-content:space-between;
            align-items:center;
            position:sticky;
            top:0;
            z-index:1000;
        }

        .timer-box{
            background:#ef4444;
            color:white;
            padding:12px 25px;
            border-radius:12px;
            font-weight:bold;
            font-size:18px;
        }

        .exam-layout{
            display:grid;
            grid-template-columns: 2fr 1fr;
            gap:25px;
            padding:25px;
        }

        .question-card{
            background:white;
            border-radius:20px;
            padding:30px;
            box-shadow:0 8px 25px rgba(0,0,0,.08);
        }

        .option{
            border:1px solid #ddd;
            border-radius:12px;
            padding:15px;
            margin-bottom:12px;
            transition:.3s;
        }

        .option:hover{
            background:#eef4ff;
        }

        .sidebar-panel{
            display:flex;
            flex-direction:column;
            gap:20px;
        }

        .webcam-card,
        .palette-card,
        .proctor-card{
            background:white;
            border-radius:20px;
            padding:20px;
            box-shadow:0 8px 25px rgba(0,0,0,.08);
        }

        video{
            width:100%;
            border-radius:12px;
            background:black;
        }

        .palette{
            display:grid;
            grid-template-columns:repeat(5,1fr);
            gap:10px;
        }

        .palette button{
            border:none;
            padding:10px;
            border-radius:10px;
            background:#2563eb;
            color:white;
        }

        .status-good{
            color:#22c55e;
            font-weight:bold;
        }

        .action-buttons{
            display:flex;
            justify-content:space-between;
            margin-top:25px;
        }

        @media(max-width:992px){

            .exam-layout{
                grid-template-columns:1fr;
            }

        }

    </style>

</head>

<body>

<!-- HEADER -->

<div class="exam-header">

    <div>

        <h4 class="mb-0">
            Java Advanced Examination
        </h4>

        <small>
            Candidate: Student
        </small>

    </div>

    <div class="timer-box">

        <i class="fas fa-clock"></i>

        <span id="timer">
            60:00
        </span>

    </div>

</div>

<!-- MAIN LAYOUT -->

<div class="exam-layout">

    <!-- QUESTION AREA -->

    <div class="question-card">

        <h5 class="mb-4">
            Question 1 of 20
        </h5>

        <h4 class="mb-4">

            Which interface must be implemented
            directly to create a Generic Servlet
            from scratch?

        </h4>

        <form id="examForm">

            <div class="option">

                <input type="radio"
                       name="q1"
                       value="A">

                ServletConfig

            </div>

            <div class="option">

                <input type="radio"
                       name="q1"
                       value="B">

                ServletRequest

            </div>

            <div class="option">

                <input type="radio"
                       name="q1"
                       value="C">

                Servlet

            </div>

            <div class="option">

                <input type="radio"
                       name="q1"
                       value="D">

                HttpServlet

            </div>

        </form>

        <div class="action-buttons">

            <button class="btn btn-secondary">

                Previous

            </button>

            <button class="btn btn-primary">

                Save & Next

            </button>

            <button class="btn btn-success">

                Submit Exam

            </button>

        </div>

    </div>

    <!-- SIDEBAR -->

    <div class="sidebar-panel">

        <!-- WEBCAM -->

        <div class="webcam-card">

            <h5>

                <i class="fas fa-camera"></i>

                Live Webcam

            </h5>

            <video id="webcam"
                   autoplay
                   muted>

            </video>

        </div>

        <!-- AI PROCTOR -->

        <div class="proctor-card">

            <h5>

                <i class="fas fa-shield-alt"></i>

                AI Proctor Status

            </h5>

            <hr>

            <p>

                Face Detection:
                <span class="status-good">
                    Active
                </span>

            </p>

            <p>

                Fullscreen:
                <span class="status-good">
                    Enabled
                </span>

            </p>

            <p>

                Violations:
                <span id="violations">

                    0

                </span>

            </p>

        </div>

        <!-- QUESTION PALETTE -->

        <div class="palette-card">

            <h5>

                Question Palette

            </h5>

            <hr>

            <div class="palette">

                <button>1</button>
                <button>2</button>
                <button>3</button>
                <button>4</button>
                <button>5</button>
                <button>6</button>
                <button>7</button>
                <button>8</button>
                <button>9</button>
                <button>10</button>
                <button>11</button>
                <button>12</button>
                <button>13</button>
                <button>14</button>
                <button>15</button>
                <button>16</button>
                <button>17</button>
                <button>18</button>
                <button>19</button>
                <button>20</button>

            </div>

        </div>

    </div>

</div>

<script src="js/timer.js"></script>
<script src="js/proctor.js"></script>
<script src="js/exam.js"></script>

<script>

    navigator.mediaDevices
        .getUserMedia({video:true})

        .then(stream => {

            document
                .getElementById("webcam")
                .srcObject = stream;

        })

        .catch(error => {

            console.log(error);

        });

</script>

</body>
</html>