// ======================================
// ExamShield AI - Timer Module
// ======================================

let totalTime = 60 * 60; // 60 Minutes

const timerElement =
    document.getElementById("timer");

function startTimer() {

    const timerInterval = setInterval(() => {

        let minutes =
            Math.floor(totalTime / 60);

        let seconds =
            totalTime % 60;

        minutes =
            minutes < 10 ?
            "0" + minutes :
            minutes;

        seconds =
            seconds < 10 ?
            "0" + seconds :
            seconds;

        timerElement.innerHTML =
            minutes + ":" + seconds;

        // Warning at 5 minutes

        if(totalTime === 300){

            alert(
                "Warning: Only 5 minutes remaining!"
            );

        }

        // Auto submit

        if(totalTime <= 0){

            clearInterval(timerInterval);

            alert(
                "Time is over. Exam will be submitted automatically."
            );

            document
                .getElementById("examForm")
                .submit();

        }

        totalTime--;

    },1000);

}

startTimer();