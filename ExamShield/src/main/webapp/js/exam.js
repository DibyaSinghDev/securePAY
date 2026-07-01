// ======================================
// ExamShield AI - Exam Engine
// ======================================

// Auto Save Every 30 Seconds

setInterval(() => {

    autoSave();

},30000);

// --------------------------------------
// Auto Save Function
// --------------------------------------

function autoSave(){

    console.log(
        "Answers Auto Saved"
    );

    // AJAX save can be added later

}

// --------------------------------------
// Save Answer
// --------------------------------------

const options =
    document.querySelectorAll(
        "input[type='radio']"
    );

options.forEach(option => {

    option.addEventListener(
        "change",
        function(){

            console.log(
                "Answer Saved"
            );

        }
    );

});

// --------------------------------------
// Submit Exam
// --------------------------------------

function submitExam(){

    const confirmSubmit =
        confirm(
            "Are you sure you want to submit the exam?"
        );

    if(confirmSubmit){

        document
            .getElementById("examForm")
            .submit();

    }

}

// --------------------------------------
// Question Navigation
// --------------------------------------

const paletteButtons =
    document.querySelectorAll(
        ".palette button"
    );

paletteButtons.forEach(button => {

    button.addEventListener(
        "click",
        function(){

            let questionNumber =
                this.innerText;

            console.log(
                "Navigate to Question "
                + questionNumber
            );

            // Future AJAX Question Loading

        }
    );

});

// --------------------------------------
// Exam Activity Log
// --------------------------------------

function logActivity(message){

    console.log(
        "[Exam Log] " + message
    );

}

logActivity(
    "Exam Started Successfully"
);