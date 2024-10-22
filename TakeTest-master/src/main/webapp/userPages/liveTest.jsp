<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, dao.Question"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Live Test</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      margin-top: 50px;
      padding: 0;
      background-color: #83C5BE;
      display: flex;
      justify-content: center;
    }
    #countdown {
  position: absolute;
  top: 15px; /* Adjust as needed */
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  font-size: 24px;
  padding: 5px;
  margin-bottom: 15px;
  background-color: #1cac78;
  color: white;
  border-radius: 5px;
}

    .container {
      display: flex;
      flex-direction: row;
      width: 95%;
      height: 87vh;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      border-radius: 5px;
      overflow: hidden;
      position: relative;
    }
    .question-section {
      flex: 4;
      padding: 20px;
      font-size: 20px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .question-item {
      margin-bottom: 15px;
    }
    .question-item h3 {
      margin-top: 0;
      color: #333;
    }
    .options {
      list-style-type: none;
      padding: 0;
      margin: 10px 0;
    }
    .options li {
      margin-bottom: 5px;
    }
    .options label {
      display: flex;
      align-items: center;
    }
    .options input[type="radio"] {
      margin-right: 10px;
    }
    .buttons-section {
      display: flex;
      justify-content: center;
      margin-top: 20px;
    }
    button {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      margin-right: 10px;
    }
    button:hover {
      background-color: #3e8e41;
    }
    button:disabled {
      background-color: #ccc;
      cursor: not-allowed;
    }
    #submitButton {
      background-color: #006D77;
    }
    #submitButton:hover {
      background-color: #d32f2f;
    }
    .question-nav {
      flex: 1;
      background-color: #006D77;
      padding: 20px;
    }
    .question-nav ul {
      list-style-type: none;
      padding: 0;
      margin: 0;
    }
    .question-nav li {
      margin-bottom: 10px;
    }
    .question-nav a {
      display: block;
      padding: 10px;
      background-color: #fff;
      border-radius: 5px;
      text-decoration: none;
      color: #333;
      transition: background-color 0.3s ease;
    }
    .question-nav a.answered {
      background-color: #4CAF50;
      color: white;
    }
    .question-nav a.unattempted {
      background-color: #fff;
      color: black;
    }
    .question-nav a.marked-for-review {
      background-color: #f5b700 !important;
      color: white;
    }
    .question-nav a:hover {
      background-color: #e0e0e0;
    }
    #markForReviewButton:hover {
      background-color: #f5b100;
    }
    button {
      color: black;
    }
    .video-section {
      position: absolute;
      bottom: 0;
      right: 0;
      margin: 20px;
      border: 1px solid #ccc;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    #videoElement {
      width: auto;
      height: 100px;
    } 
	
	#fullscreen-modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(255, 255, 255, 0.8); /* White background with transparency */
}

	#fullscreen-modal {
		
		border-color: 5px solid black;
	    background-color: #f5f5f5; 
	    padding: 20px;
	    border-radius: 10px;
	    width: 100%;
	    height: 100vh;
	    text-align: center;
	    justigy-content: center;
	}
	
	#fullscreen-modal h2 {
	    color: #333; /* Dark gray text */
	}
	
	#fullscreen-modal p {
	    color: #666; /* Medium gray text */
	    margin-bottom: 20px;
	}
	
	#fullscreen-modal .buttons {
	    display: flex;
	    justify-content: center;
	}
	
	#fullscreen-modal .buttons button {
	    padding: 10px 20px;
	    margin: 0 10px;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	}
	
	#fullscreen-modal .buttons button:hover {
	    background-color: #f5b700; /* Light orange on hover */
	}
	
	#fullscreen-modal .buttons button#enter-fullscreen-button {
	    background-color: #4CAF50; /* Green button */
	    color: #fff; /* White text */
	}
	
	#fullscreen-modal .buttons button#back-button {
	    background-color: #f44336; /* Red button */
	    color: #fff; /* White text */
	}
    
  </style>
</head>
<body>

  <% HttpSession session2 = request.getSession(false);
  if (session2 != null && session2.getAttribute("user_id") != null) { %>
	<div id="countdown">
    <span id="minutes">00</span>:<span id="seconds">00</span>
  </div> 
  <div class="container">
	  
    <div class="question-section">
      <% ArrayList<Question> questions = (ArrayList<Question>) session.getAttribute("questions");
      if (questions != null) { %>
      <div class="question-item">
        <h3>Question <span id="questionNumber"></span>:</h3>
        <p><span id="questionText"></span></p>
        <ul class="options" id="optionsList">
          <!-- Options will be dynamically populated here -->
        </ul>
      </div>
      <div class="buttons-section">
        <button id="prevButton" disabled>Previous</button>
        <button id="nextButton">Next</button>
        <button id="markForReviewButton" style="background-color: #83C5BE">Mark for Review</button>
        <button id="submitButton" style="display: none; color: white;">Submit Test</button>
      </div>
      <% } %>
    </div>
    <!-- Video capturing section -->
    <div class="video-section">
      <video id="videoElement" autoplay></video>
    </div>
    <div class="question-nav">
      <h2 style="color: white;">Questions</h2>
      <ul>
        <% for (int i = 0; i < questions.size(); i++) { %>
        <li>
          <a href="#" class="unattempted" data-question-index="<%=i%>">
            Question <%=i + 1%>
          </a>
        </li>
        <% } %>
      </ul>
    </div>
  </div>

  
  <script>
  

  // full screen mode --------------------------------------------------------------------------------
  
  // no. of times screen changed
  var count = 0;
  
  document.addEventListener("DOMContentLoaded", function() {
      const fullscreenModal = document.getElementById('fullscreen-modal');
      const enterFullscreenButton = document.getElementById('enter-fullscreen-button');
      const backButton = document.getElementById('back-button');

     // fullscreenModal.classList.remove('hidden');
      fullscreenModal.style.display = "block";
      
      enterFullscreenButton.addEventListener('click', () => {
          enterFullscreen();
          showQuestion(currentQuestionIndex);
          if (!startTime) {
              startTime = Date.now(); // Get the current timestamp
              startTimer();
          }
      });

      backButton.addEventListener('click', () => {
          window.location.href = "/TakeTest/UserDashboard";
      });
      
      // Function to enter fullscreen mode
      function enterFullscreen() {
          if (document.documentElement.requestFullscreen) {
              document.documentElement.requestFullscreen();
          } else if (document.documentElement.webkitRequestFullscreen) {
              document.documentElement.webkitRequestFullscreen();
          } else if (document.documentElement.mozRequestFullScreen) {
              document.documentElement.mozRequestFullScreen();
          }
          fullscreenModal.style.display = "none";
      }
      
  });
  
  let isWindowFocused = true;
  let switchTimeout;

  function handleWindowBlur() {
      if (isWindowFocused) {
          // Window lost focus (switched to another application or tab)
          isWindowFocused = false;
          switchTimeout = setTimeout(() => {
              count++; // Increment the switch count after a delay
              console.log('Tab switched! Count: ' + count);
          }, 100); // Adjust the delay as needed
      }
  }

  function handleWindowFocus() {
      if (!isWindowFocused) {
          // Window regained focus (returned to the application)
          isWindowFocused = true;
          if (switchTimeout) {
              clearTimeout(switchTimeout); // Cancel the switch timeout
          }
      }
  }

  // Listen for window blur and focus events
  window.addEventListener('blur', handleWindowBlur);
  window.addEventListener('focus', handleWindowFocus);
  
  
  document.addEventListener('fullscreenchange', (event) => {
	  
	  console.log(count);
	  if (!document.fullscreenElement) {
		  count++;
	    const modal = document.getElementById('fullscreen-modal');
	    if (modal) {
	      modal.style.display = 'block'; // Show the modal
	      const abc = document.getElementById('enter-fullscreen-button');
	      abc.addEventListener('click', () => {
	          mn();
	      });
	      function mn() {
	          if (document.documentElement.requestFullscreen) {
	              document.documentElement.requestFullscreen();
	          } else if (document.documentElement.webkitRequestFullscreen) {
	              document.documentElement.webkitRequestFullscreen();
	          } else if (document.documentElement.mozRequestFullScreen) {
	              document.documentElement.mozRequestFullScreen();
	          }
	          fullscreenModal.style.display = "none";
	      }
	    } 
	  }
	});


  // ------ webcam access ------------------------------------------------------------------------------------
  
  const video = document.getElementById("videoElement");

  function requestCameraPermission() {
    
    navigator.mediaDevices.getUserMedia({ video: true })
      .then(function(stream) {
        // User granted permission
        startVideoCapture(stream);
      })
      .catch(function(error) {
        console.log("Error accessing webcam:", error);
        const permissionDenied = confirm("Access to the camera is required. Give access and click 'Ok' to proceed or 'Cancel' to go back to Dashboard.");
        if (permissionDenied) {
          // Repeatedly ask for permission until granted
          requestCameraPermission();
        } else {
          window.location.href = "/TakeTest/UserDashboard";
        }
      });
  }

  if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
    // Initial request for camera permission
    requestCameraPermission();
  } else {
    console.log("getUserMedia is not supported by this browser");
  }

  function startVideoCapture(stream) {
    video.srcObject = stream;
  }
  
  // questions 
    const questionItems = document.querySelectorAll('.question-item');
    const questionLinks = document.querySelectorAll('.question-nav a');
    const prevButton = document.getElementById('prevButton');
    const nextButton = document.getElementById('nextButton');
    const markForReviewButton = document.getElementById('markForReviewButton');
    const submitButton = document.getElementById('submitButton');
    const questionNumberElement = document.getElementById('questionNumber');
    const questionTextElement = document.getElementById('questionText');
    const optionsListElement = document.getElementById('optionsList');
    const timerElement = document.getElementById('demo');

    const questions = [
      <%ArrayList<Question> arr = (ArrayList<Question>) session.getAttribute("questions");
      for (Question question : arr) {%>
      { text: '<%=question.getQuesText().replaceAll("'", "\\'")%>', options: [
        '<%=question.getOption1().replaceAll("'", "\\'")%>',
        '<%=question.getOption2().replaceAll("'", "\\'")%>',
        '<%=question.getOption3().replaceAll("'", "\\'")%>',
        '<%=question.getOption4().replaceAll("'", "\\'")%>'
      ]},
      <%}%>
    ];
	
    var startTime;
    let currentQuestionIndex = 0;
    const userResponses = new Array(questions.length).fill(null);
    const markedForReview = new Array(questions.length).fill(false);

    const totalTime = questions.length * 1 * 60; // 5 minutes per question, in seconds
    let remainingTime = totalTime;
    let timerInterval;

    function updateTimer() {
        const minutes = Math.floor(remainingTime / 60);
        const seconds = remainingTime % 60;
        const minutesText = minutes.toString().padStart(2, '0');
        const secondsText = seconds.toString().padStart(2, '0');
        document.getElementById('minutes').textContent = minutesText;
        document.getElementById('seconds').textContent = secondsText;

        if (remainingTime === 30) {
            document.getElementById('countdown').style.backgroundColor = '#f44336';
        }
        if (remainingTime === 0) {
            submitTestOnTimeout();
        } else {
            remainingTime--;
        }
    }

    function startTimer() {
      remainingTime = totalTime;
      timerInterval = setInterval(updateTimer, 1000);
    }

    function showQuestion(index) {
      const question = questions[index];
      questionNumberElement.textContent = index + 1;
      questionTextElement.innerHTML = question.text;
      optionsListElement.innerHTML = '';
      question.options.forEach((option, optionIndex) => {
        const listItem = document.createElement('li');
        const label = document.createElement('label');
        const radio = document.createElement('input');
        radio.type = 'radio';
        radio.name = 'option';
        radio.value = optionIndex + 1;
        radio.addEventListener('change', () => {
          userResponses[index] = optionIndex + 1;
          updateQuestionLink(index, 'answered');
        });
        if (userResponses[index] === optionIndex + 1) {
          radio.checked = true;
        }
        label.appendChild(radio);
        label.appendChild(document.createTextNode(option));
        listItem.appendChild(label);
        optionsListElement.appendChild(listItem);
      });
      questionLinks.forEach((link, i) => {
        if (i === index) {
          link.classList.add('active');
        } else {
          link.classList.remove('active');
        }
        updateQuestionLink(i, markedForReview[i] ? 'marked-for-review' : userResponses[i] ? 'answered' : 'unattempted');
      });
      updateNavigationButtons();
    }

    function updateQuestionLink(index, status) {
      const link = questionLinks[index];
      link.classList.remove('unattempted', 'answered', 'marked-for-review');
      link.classList.add(status);
    }

    function updateNavigationButtons() {
      prevButton.disabled = currentQuestionIndex === 0;
      nextButton.disabled = currentQuestionIndex === questions.length - 1;
      submitButton.style.display = currentQuestionIndex === questions.length - 1 ? 'inline-block' : 'none';
    }

    function markForReview() {
      const currentIndex = currentQuestionIndex;
      markedForReview[currentIndex] = !markedForReview[currentIndex];
      updateQuestionLink(currentIndex, markedForReview[currentIndex] ? 'marked-for-review' : userResponses[currentIndex] ? 'answered' : 'unattempted');
    }
    
    
    function submitTestOnTimeout() {
        const confirmSubmit = confirm('Time is up! Submit your test?');
        if (confirmSubmit) {
            clearInterval(timerInterval);
            document.removeEventListener('fullscreenchange', ()=>{
            	console.log("listener removed");
            });
            
            const answersString = userResponses.join(',');
            const form = document.createElement('form');
            form.setAttribute('method', 'post');
            form.setAttribute('action', '/TakeTest/Result');
            
            const answersInput = document.createElement('input');
            answersInput.setAttribute('type', 'hidden');
            answersInput.setAttribute('name', 'answers');
            answersInput.setAttribute('value', answersString);
            
            const switches = document.createElement('input');
            switches.setAttribute('type', 'hidden');
            switches.setAttribute('name', 'tab_switch');
            switches.setAttribute('value', count);	
            
            form.appendChild(answersInput);
            form.appendChild(switches);
            document.body.appendChild(form);
            form.submit();
        }
    }

    function submitTest() {
      const confirmSubmit = confirm('Do you want ... to submit the test?');
      if (confirmSubmit) {
        clearInterval(timerInterval);
        const answersString = userResponses.join(',');
        const form = document.createElement('form');
        form.setAttribute('method', 'post');
        form.setAttribute('action', '/TakeTest/Result');
        
        const answersInput = document.createElement('input');
        answersInput.setAttribute('type', 'hidden');
        answersInput.setAttribute('name', 'answers');
        answersInput.setAttribute('value', answersString);
        
        const switches = document.createElement('input');
        switches.setAttribute('type', 'hidden');
        switches.setAttribute('name', 'tab_switch');
        switches.setAttribute('value', count);
        
        form.appendChild(answersInput);
        form.appendChild(switches);
        
        document.body.appendChild(form);       
        
        form.submit();
      }
    }

    prevButton.addEventListener('click', () => {
      currentQuestionIndex--;
      showQuestion(currentQuestionIndex);
    });

    nextButton.addEventListener('click', () => {
      currentQuestionIndex++;
      showQuestion(currentQuestionIndex);
    });

    markForReviewButton.addEventListener('click', markForReview);
    submitButton.addEventListener('click', submitTest);

    questionLinks.forEach((link, index) => {
      link.addEventListener('click', () => {
        currentQuestionIndex = index;
        showQuestion(currentQuestionIndex);
      });
    });
    
  </script>
  <% } else response.sendRedirect("/TakeTest/userPages/userLogin.jsp"); %>
  
  <!-- Full-screen modal -->
    <div id="fullscreen-modal" class="modal">
        <h2>Enter Fullscreen Mode</h2>
        <p>This test requires fullscreen mode to proceed further. Would you like to enter fullscreen mode?</p>
        <div class="buttons">
            <button id="enter-fullscreen-button">Yes</button>
            <button id="back-button">No (Go Back)</button>
        </div>
    </div>
</body>
</html>