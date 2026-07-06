<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if(session.getAttribute("user")==null){response.sendRedirect("Login.jsp");return;}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>SecurePAY | Loan Application</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{
  --ink:#0B1B33;
  --ink-2:#14294c;
  --gold:#C9A44C;
  --gold-soft:#e4c98a;
  --paper:#F7F4EC;
  --paper-line:#E4DFC9;
  --ledger-ink:#1F2A3B;
  --credit:#1E7B4D;
  --debit:#B23A2E;
  --muted:#6B7280;
  --radius:18px;
}
*{margin:0;padding:0;box-sizing:border-box;font-family:'Inter',sans-serif}
body{
  background:
    radial-gradient(ellipse at top left, rgba(201,164,76,.10), transparent 55%),
    linear-gradient(160deg,var(--ink) 0%,var(--ink-2) 55%,#0d2044 100%);
  color:#fff;min-height:100vh;
}

.container{width:92%;max-width:1000px;margin:44px auto 70px}

/* ---------- Header ---------- */
.head{
  display:flex;gap:18px;align-items:center;margin-bottom:26px;
}
.icon{
  width:58px;height:58px;border-radius:14px;
  background:linear-gradient(155deg,#1a3663,#0e2145);
  border:1px solid rgba(201,164,76,.35);
  color:var(--gold);
  display:flex;align-items:center;justify-content:center;font-size:24px;
}
.head .eyebrow{
  font-family:'IBM Plex Mono',monospace;font-size:12px;letter-spacing:2px;
  text-transform:uppercase;color:var(--gold-soft);
}
.head h2{font-family:'Fraunces',serif;font-size:30px;font-weight:600;margin-top:4px}
.head p{color:rgba(255,255,255,.6);font-size:14px;margin-top:4px}

/* ---------- Ledger panel wrapping the form ---------- */
.panel{
  background:var(--paper);color:var(--ledger-ink);
  border-radius:var(--radius);
  padding:34px 36px;
  box-shadow:0 20px 45px rgba(0,0,0,.3);
}

/* ---------- Loan type cards ---------- */
.cards{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:8px}
.c{
  border:1px solid var(--paper-line);
  background:#fff;
  padding:18px 12px;border-radius:12px;text-align:center;
  cursor:pointer;transition:.18s;
  font-size:13.5px;font-weight:600;color:var(--ledger-ink);
}
.c i{font-size:20px;color:var(--muted);display:block;margin-bottom:8px;transition:.18s}
.c:hover{border-color:var(--gold);background:#FBF8EF}
.c.a{
  background:var(--ink);color:#fff;border-color:var(--ink);
}
.c.a i{color:var(--gold-soft)}

/* ---------- Form fields ---------- */
.grid{display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-top:24px}
label{
  display:block;margin-bottom:8px;
  color:var(--muted);font-size:12.5px;font-weight:600;
  letter-spacing:.5px;text-transform:uppercase;
}
input,select,textarea{
  width:100%;padding:13px 14px;border:1px solid #D8D2BC;border-radius:10px;
  background:#fff;color:var(--ledger-ink);font-family:'Inter',sans-serif;font-size:14.5px;
}
input,select{font-family:'IBM Plex Mono',monospace}
textarea{font-family:'Inter',sans-serif;resize:vertical}
input:focus,select:focus,textarea:focus{
  outline:2px solid var(--gold-soft);outline-offset:1px;border-color:var(--gold);
}

/* ---------- Summary ---------- */
.sum{
  margin-top:26px;padding:22px 24px;background:#fff;
  border:1px dashed var(--paper-line);border-radius:14px;
}
.sum h3{font-family:'Fraunces',serif;font-size:17px;margin-bottom:14px;color:var(--ink)}
.sum p{
  display:flex;justify-content:space-between;
  padding:8px 0;border-bottom:1px solid var(--paper-line);
  font-size:13.5px;color:var(--muted);
}
.sum p:last-child{border-bottom:none}
.sum b{font-family:'IBM Plex Mono',monospace;color:var(--ledger-ink);font-weight:600}
.status-pill{
  background:rgba(201,164,76,.15);color:#8a6a1f;
  padding:4px 12px;border-radius:20px;font-size:12px;font-weight:700;
  letter-spacing:.4px;
}

button{
  margin-top:24px;width:100%;padding:16px;
  background:var(--ink);color:#fff;border:none;border-radius:12px;
  font-size:15px;font-weight:600;cursor:pointer;transition:.2s;
  display:flex;align-items:center;justify-content:center;gap:9px;
}
button:hover{background:var(--ink-2)}
button:focus-visible{outline:2px solid var(--gold);outline-offset:2px}

a.back{
  text-decoration:none;color:var(--gold-soft);
  display:inline-block;margin-top:20px;font-size:13.5px;font-weight:500;
}
a.back:hover{color:var(--gold)}

@media(max-width:900px){
  .container{width:94%}
  .cards{grid-template-columns:repeat(2,1fr)}
  .grid{grid-template-columns:1fr}
  .panel{padding:24px 20px}
}
</style>
<script>
function s(t,e){
 document.getElementById('loanType').value=t;
 document.getElementById('lt').innerHTML=t;
 document.querySelectorAll('.c').forEach(x=>x.classList.remove('a'));
 e.classList.add('a');
}
function emi(){
 let p=parseFloat(document.getElementById('loanAmount').value)||0;
 let n=parseInt(document.getElementById('duration').value)||12;
 let r=10.5/12/100;
 let v=(p*r*Math.pow(1+r,n))/(Math.pow(1+r,n)-1);
 if(!isFinite(v))v=0;
 document.getElementById('emi').innerHTML='₹'+v.toFixed(2);
 document.getElementById('amt').innerHTML='₹'+p.toLocaleString();
}
</script>
</head>
<body>
<div class='container'>

<div class='head'>
<div class='icon'><i class='fa-solid fa-building-columns'></i></div>
<div>
<div class="eyebrow">Loans</div>
<h2>Apply for Loan</h2>
<p>Submit your request for approval.</p>
</div>
</div>

<div class="panel">
<form action='LoanServlet' method='post'>
<input type='hidden' id='loanType' name='loanType' value='Personal Loan'>

<div class='cards'>
<div class='c a' onclick="s('Personal Loan',this)"><i class='fa-solid fa-user'></i>Personal</div>
<div class='c' onclick="s('Home Loan',this)"><i class='fa-solid fa-house'></i>Home</div>
<div class='c' onclick="s('Education Loan',this)"><i class='fa-solid fa-graduation-cap'></i>Education</div>
<div class='c' onclick="s('Vehicle Loan',this)"><i class='fa-solid fa-car'></i>Vehicle</div>
</div>

<div class='grid'>
<div>
<label>Loan Amount</label>
<input id='loanAmount' name='loanAmount' type='number' onkeyup='emi()' required>
</div>
<div>
<label>Duration (months)</label>
<select id='duration' name='duration' onchange='emi()'>
<option>12</option>
<option>24</option>
<option>36</option>
<option>48</option>
<option>60</option>
</select>
</div>
<div>
<label>Monthly Income</label>
<input name='monthlyIncome' type='number' required>
</div>
<div>
<label>Employment</label>
<select name="employment">
<option>Salaried</option>
<option>Business</option>
<option>Self Employed</option>
<option>Student</option>
</select>
</div>
<div style='grid-column:1/-1'>
<label>Purpose</label>
<textarea name='purpose' rows='4' required></textarea>
</div>
</div>

<div class='sum'>
<h3>Summary</h3>
<p>Type <b id='lt'>Personal Loan</b></p>
<p>Amount <b id='amt'>₹0</b></p>
<p>Estimated EMI <b id='emi'>₹0</b></p>
<p>Status <span class="status-pill">Pending</span></p>
</div>

<button type='submit'><i class='fa-solid fa-paper-plane'></i> Submit Application</button>
</form>
<a class="back" href='Dashboard.jsp'>← Back to Dashboard</a>
</div>

</div>
</body>
</html>
