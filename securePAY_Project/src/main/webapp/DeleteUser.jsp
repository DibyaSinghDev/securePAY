<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Delete User</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600&family=Manrope:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">

<style>

:root{
    --metal:#1a1613;
    --metal-raised:#242019;
    --metal-deep:#100d0b;
    --line:#3a3227;
    --brass:#c9a227;
    --brass-bright:#e8c765;
    --lamp-red:#e0554a;
    --lamp-red-bright:#f0776c;
    --lamp-red-dim:#3a1e1b;
    --ivory:#f3ede0;
    --gray:#948c78;
}

*{ margin:0; padding:0; box-sizing:border-box; font-family:'Manrope',sans-serif; }

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:radial-gradient(circle at 50% 0%, #201b16 0%, var(--metal-deep) 65%);
    color:var(--ivory);
}

::selection{ background:var(--lamp-red); color:#160b0a; }

.card{
    width:440px;
    padding:40px;
    background:var(--metal);
    border:1px solid var(--lamp-red-dim);
    border-radius:20px;
    box-shadow:0 0 40px rgba(224,85,74,.08);
}

.hazard{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;
    margin-bottom:18px;
}

.hazard .stripe{
    height:6px;
    flex:1;
    background:repeating-linear-gradient(
        135deg,
        var(--lamp-red) 0 10px,
        var(--metal-deep) 10px 20px
    );
    border-radius:3px;
    opacity:.65;
}

.icon-ring{
    width:56px; height:56px;
    margin:0 auto 18px;
    border-radius:50%;
    border:1px dashed var(--lamp-red);
    display:flex; align-items:center; justify-content:center;
    color:var(--lamp-red-bright);
    font-size:22px;
    font-weight:700;
}

.eyebrow{
    text-align:center;
    font-family:'JetBrains Mono',monospace;
    font-size:11px;
    letter-spacing:2.5px;
    text-transform:uppercase;
    color:var(--lamp-red);
    margin-bottom:8px;
}

h2{
    text-align:center;
    font-family:'Fraunces',serif;
    font-weight:600;
    font-size:24px;
    margin-bottom:10px;
}

.warning{
    text-align:center;
    font-size:13.5px;
    color:var(--gray);
    line-height:1.6;
    margin-bottom:26px;
}

.warning b{ color:var(--lamp-red-bright); }

label{
    display:block;
    font-family:'JetBrains Mono',monospace;
    font-size:11px;
    letter-spacing:1.2px;
    text-transform:uppercase;
    color:var(--gray);
    text-align:left;
    margin-bottom:8px;
}

input{
    width:100%;
    padding:13px 14px;
    margin-bottom:22px;
    background:var(--metal-deep);
    border:1px solid var(--line);
    border-radius:10px;
    color:var(--ivory);
    font-family:'JetBrains Mono',monospace;
    font-size:14.5px;
    transition:border-color .15s;
}

input::placeholder{ color:var(--gray); }
input:focus{ outline:none; border-color:var(--lamp-red); }

button{
    width:100%;
    padding:15px;
    border:none;
    border-radius:10px;
    background:var(--lamp-red);
    color:var(--ivory);
    font-size:14.5px;
    font-weight:700;
    letter-spacing:.4px;
    text-transform:uppercase;
    font-family:'Manrope',sans-serif;
    cursor:pointer;
    transition:background .15s;
}

button:hover{ background:#c8483e; }
button:focus-visible{ outline:2px solid var(--lamp-red-bright); outline-offset:3px; }

.back{
    display:block;
    text-align:center;
    margin-top:18px;
    text-decoration:none;
    color:var(--gray);
    font-size:13px;
    font-family:'JetBrains Mono',monospace;
    transition:color .15s;
}

.back:hover{ color:var(--ivory); }

</style>
</head>

<body>

<div class="card">

    <div class="hazard"><div class="stripe"></div></div>

    <div class="icon-ring">!</div>

    <div class="eyebrow">Irreversible action</div>
    <h2>Delete User</h2>

    <p class="warning">
        This permanently removes the account and its transaction history.
        <b>This cannot be undone.</b> Confirm the account number carefully.
    </p>

    <form action="DeleteUserServlet" method="post"
          onsubmit="return confirm('Permanently delete this account? This cannot be undone.');">

        <label for="accountNumber">Account number</label>
        <input
            id="accountNumber"
            type="text"
            name="accountNumber"
            placeholder="e.g. 4471 2200 9981"
            required
            autocomplete="off">

        <button type="submit">Delete user</button>

    </form>

    <a href="AdminDashboardServlet" class="back">← Back to dashboard</a>

</div>

</body>
</html>