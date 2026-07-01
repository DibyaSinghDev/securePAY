<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY AI Assistant</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Segoe UI,sans-serif}
body{background:linear-gradient(135deg,#0b1f5e,#2563eb);min-height:100vh}
.chat-toggle{position:fixed;right:25px;bottom:25px;width:70px;height:70px;border-radius:50%;background:#2563eb;color:#fff;font-size:32px;display:flex;align-items:center;justify-content:center;cursor:pointer;box-shadow:0 10px 30px rgba(0,0,0,.35)}
.chat-box{position:fixed;right:25px;bottom:105px;width:390px;height:650px;background:#fff;border-radius:24px;overflow:hidden;display:none;flex-direction:column;box-shadow:0 15px 40px rgba(0,0,0,.3)}
.header{background:linear-gradient(90deg,#1d4ed8,#3b82f6);color:#fff;padding:18px;display:flex;justify-content:space-between;align-items:center}
.online{font-size:13px;display:flex;align-items:center;gap:6px}.dot{width:10px;height:10px;background:#22c55e;border-radius:50%;animation:pulse 1.5s infinite}
@keyframes pulse{0%{box-shadow:0 0 0 0 rgba(34,197,94,.5)}100%{box-shadow:0 0 0 12px rgba(34,197,94,0)}}
.quick{display:flex;gap:8px;overflow:auto;padding:10px;background:#f5f8ff}
.quick button{border:none;background:#e3edff;color:#2563eb;padding:8px 12px;border-radius:20px;cursor:pointer;white-space:nowrap}
.messages{flex:1;overflow:auto;background:#eef5ff;padding:15px}
.bot,.user{max-width:78%;padding:12px 16px;margin-bottom:12px;word-wrap:break-word}
.bot{background:#fff;border-radius:18px 18px 18px 5px;box-shadow:0 3px 10px rgba(0,0,0,.08)}
.user{margin-left:auto;background:#0b8457;color:#fff;border-radius:18px 18px 5px 18px}
.emoji-panel{display:none;padding:10px;background:#fff;border-top:1px solid #ddd;font-size:22px;cursor:pointer}
.footer{display:flex;gap:8px;padding:12px;background:#fff}
.footer input{flex:1;padding:12px;border:1px solid #ccc;border-radius:12px}
.footer button{padding:12px 14px;border:none;background:#2563eb;color:#fff;border-radius:12px;cursor:pointer}
.typing{display:flex;align-items:center;gap:6px;width:60px}
.typing span{width:10px;height:10px;background:#6b7280;border-radius:50%;animation:typing 1.2s infinite ease-in-out}
.typing span:nth-child(2){animation-delay:.2s}.typing span:nth-child(3){animation-delay:.4s}
@keyframes typing{0%,80%,100%{transform:translateY(0);opacity:.4}40%{transform:translateY(-8px);opacity:1}}
</style>
</head>
<body>
<div class="chat-toggle" onclick="toggleChat()">🤖</div>

<div class="chat-box" id="chatBox">
<div class="header">
<div><b>SecurePAY AI</b><div class="online"><span class="dot"></span>Online</div></div>
<div style="cursor:pointer" onclick="toggleChat()">✕</div>
</div>

<div class="quick">
<button onclick="ask('Show my balance')">💰 Balance</button>
<button onclick="ask('Recent transactions')">📄 Transactions</button>
<button onclick="ask('Account number')">🏦 Account</button>
<button onclick="ask('Recharge')">📱 Recharge</button>
<button onclick="ask('Loan')">💳 Loan</button>
</div>

<div class="messages" id="messages">
<div class="bot">👋 Welcome to SecurePAY! I'm your banking assistant. Ask me about your balance, account, passbook, recharge or recent transactions.</div>
</div>

<div class="emoji-panel" id="emojiPanel">😀 😁 😂 😊 😍 😎 👍 👏 ❤️ 💰 💳 🏦 📄 🤖 🎉</div>

<div class="footer">
<button onclick="toggleEmoji()">😊</button>
<input id="message" placeholder="Type your message..." onkeydown="if(event.key==='Enter')sendMessage();">
<button onclick="sendMessage()">Send</button>
</div>
</div>

<script>
function toggleChat(){
 const c=document.getElementById("chatBox");
 c.style.display=(c.style.display==="flex")?"none":"flex";
}
function toggleEmoji(){
 const p=document.getElementById("emojiPanel");
 p.style.display=(p.style.display==="block")?"none":"block";
}
document.getElementById("emojiPanel").onclick=function(e){
 if(e.target.textContent.trim()){
   document.getElementById("message").value+=e.target.textContent;
 }
}
function ask(q){
 document.getElementById("message").value=q;
 sendMessage();
}
function sendMessage(){
 const input=document.getElementById("message");
 const msg=input.value.trim();
 if(msg==="") return;
 const messages=document.getElementById("messages");

 messages.innerHTML+="<div class='user'>"+msg+"</div>";
 messages.innerHTML+="<div class='bot typing' id='typing'><span></span><span></span><span></span></div>";
 messages.scrollTop=messages.scrollHeight;
 input.value="";

 setTimeout(function(){
   fetch("<%=request.getContextPath()%>/ChatbotServlet",{
      method:"POST",
      headers:{"Content-Type":"application/x-www-form-urlencoded"},
      body:"message="+encodeURIComponent(msg)
   })
   .then(r=>r.text())
   .then(data=>{
      const t=document.getElementById("typing");
      if(t) t.remove();
      messages.innerHTML+="<div class='bot'>"+data.replace(/\n/g,"<br>")+"</div>";
      messages.scrollTop=messages.scrollHeight;
   })
   .catch(()=>{
      const t=document.getElementById("typing");
      if(t) t.remove();
      messages.innerHTML+="<div class='bot'>⚠ Unable to connect to ChatbotServlet.</div>";
   });
 },3000);
}
</script>
</body>
</html>
