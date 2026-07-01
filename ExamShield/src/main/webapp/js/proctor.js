// ======================================
// ExamShield AI - AI Proctoring Module
// ======================================

let violations = 0;

const violationCounter =
    document.getElementById("violations");

// Update violation count

function updateViolation() {

    violations++;

    violationCounter.innerText =
        violations;

}

// --------------------------------------
// Tab Switch Detection
// --------------------------------------

document.addEventListener(
    "visibilitychange",
    function(){

        if(document.hidden){

            updateViolation();

            alert(
                "Warning! Tab switching detected."
            );

            console.log(
                "Tab Switch Violation"
            );

        }

    }
);

// --------------------------------------
// Fullscreen Exit Detection
// --------------------------------------

document.addEventListener(
    "fullscreenchange",
    function(){

        if(!document.fullscreenElement){

            updateViolation();

            alert(
                "Fullscreen mode exited!"
            );

            console.log(
                "Fullscreen Violation"
            );

        }

    }
);

// --------------------------------------
// Right Click Restriction
// --------------------------------------

document.addEventListener(
    "contextmenu",
    function(e){

        e.preventDefault();

        updateViolation();

    }
);

// --------------------------------------
// Copy Restriction
// --------------------------------------

document.addEventListener(
    "copy",
    function(e){

        e.preventDefault();

        updateViolation();

    }
);

// --------------------------------------
// Paste Restriction
// --------------------------------------

document.addEventListener(
    "paste",
    function(e){

        e.preventDefault();

        updateViolation();

    }
);

// --------------------------------------
// Keyboard Shortcut Detection
// --------------------------------------

document.addEventListener(
    "keydown",
    function(e){

        if(

            e.ctrlKey &&
            (e.key === "c"
            || e.key === "v"
            || e.key === "u"
            || e.key === "s")

        ){

            e.preventDefault();

            updateViolation();

        }

        // F12

        if(e.keyCode === 123){

            e.preventDefault();

            updateViolation();

        }

    }
);

// --------------------------------------
// Enter Fullscreen Automatically
// --------------------------------------

window.onload = () => {

    const element =
        document.documentElement;

    if(element.requestFullscreen){

        element.requestFullscreen();

    }

};