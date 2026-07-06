<%-- ChatbotWidget.jsp
     Include this fragment on any page (e.g. Dashboard.jsp) to show the
     floating SecurePAY assistant button there:

       <jsp:include page="ChatbotWidget.jsp" />

     Place the include just before the closing </body> tag of the host page.
     All CSS classes and JS globals are prefixed "sp-chat" to avoid clashing
     with the host page's own styles/scripts.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<style>
.sp-chat-root{
--sp-paper:#f1ecde;
--sp-paper-2:#e9e3d1;
--sp-ink:#26241e;
--sp-ink-faded:#77715f;
--sp-rule:#c9c2ac;
--sp-green:#2f6e4e;
--sp-red:#a73b2e;
font-family:'IBM Plex Sans',Segoe UI,Arial,sans-serif;
}
.sp-chat-toggle{
position:fixed;
right:25px;
bottom:25px;
width:64px;
height:64px;
border-radius:50%;
background:var(--sp-ink);
color:var(--sp-paper);
display:flex;
align-items:center;
justify-content:center;
cursor:pointer;
box-shadow:0 10px 26px rgba(0,0,0,.4);
border:3px solid var(--sp-paper);
z-index:9999;
transition:transform .15s ease;
}
.sp-chat-toggle:hover{transform:scale(1.06)}
.sp-chat-toggle:focus-visible{outline:2px solid var(--sp-green);outline-offset:3px}
.sp-chat-toggle svg{width:26px;height:26px}

.sp-chat-box{
position:fixed;
right:25px;
bottom:100px;
width:380px;
max-width:calc(100vw - 30px);
height:600px;
max-height:calc(100vh - 130px);
background:var(--sp-paper);
border-radius:6px;
overflow:hidden;
display:none;
flex-direction:column;
box-shadow:0 20px 50px rgba(0,0,0,.45);
z-index:9999;
}
.sp-chat-box.sp-open{display:flex}

.sp-chat-tear{
height:10px;
background-image:
linear-gradient(-45deg,var(--sp-ink) 6px,transparent 0),
linear-gradient(45deg,var(--sp-ink) 6px,transparent 0);
background-size:12px 12px;
background-position:left top;
background-repeat:repeat-x;
}

.sp-chat-header{
background:var(--sp-ink);
color:var(--sp-paper);
padding:14px 16px;
display:flex;
justify-content:space-between;
align-items:center;
}
.sp-chat-header .sp-brand{
font-family:'Special Elite',monospace;
font-size:15px;
letter-spacing:1.5px;
}
.sp-chat-header .sp-online{
font-family:'IBM Plex Mono',monospace;
font-size:10px;
letter-spacing:1px;
text-transform:uppercase;
display:flex;
align-items:center;
gap:6px;
margin-top:4px;
opacity:.85;
}
.sp-chat-header .sp-dot{
width:7px;height:7px;border-radius:50%;background:#7fdba0;
animation:sp-pulse 1.5s infinite;
}
@keyframes sp-pulse{0%{box-shadow:0 0 0 0 rgba(127,219,160,.6)}100%{box-shadow:0 0 0 9px rgba(127,219,160,0)}}
.sp-chat-header .sp-close{cursor:pointer;font-family:'IBM Plex Mono',monospace;font-size:16px;line-height:1;padding:4px}
.sp-chat-header .sp-close:focus-visible{outline:2px solid var(--sp-paper);outline-offset:2px}

.sp-chat-quick{
display:flex;
gap:6px;
overflow-x:auto;
padding:10px 12px;
background:var(--sp-paper-2);
border-bottom:1px dashed var(--sp-rule);
}
.sp-chat-quick button{
border:1.5px solid var(--sp-ink);
background:transparent;
color:var(--sp-ink);
padding:6px 11px;
border-radius:3px;
cursor:pointer;
white-space:nowrap;
font-family:'IBM Plex Mono',monospace;
font-size:11px;
letter-spacing:.5px;
text-transform:uppercase;
}
.sp-chat-quick button:hover{background:var(--sp-ink);color:var(--sp-paper)}

.sp-chat-messages{
flex:1;
overflow-y:auto;
padding:16px;
background:var(--sp-paper);
}
.sp-chat-bot,.sp-chat-user{
max-width:82%;
padding:10px 14px;
margin-bottom:12px;
word-wrap:break-word;
font-size:13px;
line-height:1.5;
}
.sp-chat-bot{
background:#fbf9f2;
border:1px dotted var(--sp-rule);
border-radius:2px;
color:var(--sp-ink);
font-family:'IBM Plex Mono',monospace;
}
.sp-chat-user{
margin-left:auto;
background:var(--sp-ink);
color:var(--sp-paper);
border-radius:2px;
font-family:'IBM Plex Sans',sans-serif;
}

.sp-chat-emoji{
display:none;
padding:10px;
background:#fbf9f2;
border-top:1px dashed var(--sp-rule);
font-size:20px;
cursor:pointer;
}
.sp-chat-emoji.sp-open{display:block}

.sp-chat-footer{
display:flex;
gap:8px;
padding:12px;
background:var(--sp-paper-2);
border-top:1px dashed var(--sp-rule);
}
.sp-chat-footer input{
flex:1;
padding:10px 12px;
border:1.5px solid var(--sp-ink);
border-radius:2px;
background:#fbf9f2;
font-family:'IBM Plex Mono',monospace;
font-size:12px;
color:var(--sp-ink);
outline:none;
}
.sp-chat-footer input:focus-visible{outline:2px solid var(--sp-green);outline-offset:1px}
.sp-chat-footer input::placeholder{color:#a49d87}
.sp-chat-footer .sp-emoji-btn,.sp-chat-footer .sp-send-btn{
border:1.5px solid var(--sp-ink);
background:var(--sp-ink);
color:var(--sp-paper);
padding:10px 13px;
border-radius:2px;
cursor:pointer;
font-family:'IBM Plex Mono',monospace;
font-size:12px;
letter-spacing:.5px;
text-transform:uppercase;
}
.sp-chat-footer .sp-emoji-btn{background:transparent;color:var(--sp-ink)}
.sp-chat-footer button:focus-visible{outline:2px solid var(--sp-green);outline-offset:2px}

.sp-chat-typing{display:flex;align-items:center;gap:5px;width:50px;padding:10px 14px}
.sp-chat-typing span{width:6px;height:6px;background:var(--sp-ink-faded);border-radius:50%;animation:sp-typing 1.2s infinite ease-in-out}
.sp-chat-typing span:nth-child(2){animation-delay:.2s}
.sp-chat-typing span:nth-child(3){animation-delay:.4s}
@keyframes sp-typing{0%,80%,100%{transform:translateY(0);opacity:.4}40%{transform:translateY(-6px);opacity:1}}

@media(max-width:480px){
.sp-chat-box{right:12px;bottom:88px;width:calc(100vw - 24px)}
.sp-chat-toggle{right:16px;bottom:16px}
}
</style>

<div class="sp-chat-root">

<div class="sp-chat-toggle" id="spChatToggle" role="button" tabindex="0" aria-label="Open SecurePAY assistant" onclick="spToggleChat()">
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"></path></svg>
</div>

<div class="sp-chat-box" id="spChatBox">
<div class="sp-chat-tear"></div>
<div class="sp-chat-header">
<div>
<div class="sp-brand">SecurePAY Assistant</div>
<div class="sp-online"><span class="sp-dot"></span>Online</div>
</div>
<div class="sp-close" tabindex="0" role="button" aria-label="Close assistant" onclick="spToggleChat()">&#10005;</div>
</div>

<div class="sp-chat-quick">
<button onclick="spAsk('Show my balance')">Balance</button>
<button onclick="spAsk('Recent transactions')">Transactions</button>
<button onclick="spAsk('Account number')">Account</button>
<button onclick="spAsk('Recharge')">Recharge</button>
<button onclick="spAsk('Loan')">Loan</button>
</div>

<div class="sp-chat-messages" id="spMessages">
<div class="sp-chat-bot">Welcome to SecurePAY. Ask about your balance, account, passbook, recharge or recent transactions.</div>
</div>

<div class="sp-chat-emoji" id="spEmojiPanel">&#128512; &#128513; &#128522; &#128077; &#128079; &#10084; &#65039; &#128176; &#128179; &#127974;</div>

<div class="sp-chat-footer">
<button class="sp-emoji-btn" type="button" onclick="spToggleEmoji()" aria-label="Insert emoji">&#9786;</button>
<input id="spMessage" placeholder="Type your message" onkeydown="if(event.key==='Enter')spSendMessage();">
<button class="sp-send-btn" type="button" onclick="spSendMessage()">Send</button>
</div>
</div>
</div>

<script>
function spToggleChat(){
var box=document.getElementById("spChatBox");
box.classList.toggle("sp-open");
}
function spToggleEmoji(){
var p=document.getElementById("spEmojiPanel");
p.classList.toggle("sp-open");
}
document.getElementById("spEmojiPanel").addEventListener("click",function(e){
var text=e.target.textContent.trim();
if(text){
document.getElementById("spMessage").value+=text;
}
});
document.getElementById("spChatToggle").addEventListener("keydown",function(e){
if(e.key==="Enter"||e.key===" "){e.preventDefault();spToggleChat();}
});
function spAsk(q){
document.getElementById("spMessage").value=q;
spSendMessage();
}
function spEscapeHtml(str){
var div=document.createElement("div");
div.textContent=str;
return div.innerHTML;
}
function spSendMessage(){
var input=document.getElementById("spMessage");
var msg=input.value.trim();
if(msg==="") return;
var messages=document.getElementById("spMessages");

var userDiv=document.createElement("div");
userDiv.className="sp-chat-user";
userDiv.textContent=msg;
messages.appendChild(userDiv);

var typingDiv=document.createElement("div");
typingDiv.className="sp-chat-bot sp-chat-typing";
typingDiv.id="spTyping";
typingDiv.innerHTML="<span></span><span></span><span></span>";
messages.appendChild(typingDiv);

messages.scrollTop=messages.scrollHeight;
input.value="";

fetch("<%=request.getContextPath()%>/ChatbotServlet",{
method:"POST",
headers:{"Content-Type":"application/x-www-form-urlencoded"},
body:"message="+encodeURIComponent(msg)
})
.then(function(r){return r.text();})
.then(function(data){
var t=document.getElementById("spTyping");
if(t) t.remove();
var botDiv=document.createElement("div");
botDiv.className="sp-chat-bot";
botDiv.innerHTML=spEscapeHtml(data).replace(/\n/g,"<br>");
messages.appendChild(botDiv);
messages.scrollTop=messages.scrollHeight;
})
.catch(function(){
var t=document.getElementById("spTyping");
if(t) t.remove();
var botDiv=document.createElement("div");
botDiv.className="sp-chat-bot";
botDiv.textContent="Unable to connect to the assistant right now.";
messages.appendChild(botDiv);
});
}
</script>
