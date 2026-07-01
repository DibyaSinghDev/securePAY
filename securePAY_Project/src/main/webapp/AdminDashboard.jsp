
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
Integer totalUsers =
(Integer)request.getAttribute("totalUsers");

Integer totalTransactions =
(Integer)request.getAttribute("totalTransactions");

Double totalBalance =
(Double)request.getAttribute("totalBalance");

if(totalUsers == null) totalUsers = 0;
if(totalTransactions == null) totalTransactions = 0;
if(totalBalance == null) totalBalance = 0.0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SecurePAY Professional Admin Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:linear-gradient(
        135deg,
        #020617,
        #0f172a,
        #1e293b
    );
    min-height:100vh;
    color:white;
}

/* Layout */

.wrapper{
    display:flex;
}

/* Sidebar */

.sidebar{
    width:260px;
    min-height:100vh;
    background:rgba(255,255,255,.05);
    backdrop-filter:blur(20px);
    border-right:1px solid rgba(255,255,255,.08);
    padding:30px 20px;
}

.logo{
    font-size:28px;
    font-weight:700;
    text-align:center;
    margin-bottom:40px;
    color:#38bdf8;
}

.sidebar a{
    display:block;
    text-decoration:none;
    color:white;
    padding:15px;
    margin-bottom:10px;
    border-radius:15px;
    transition:.3s;
}

.sidebar a:hover{
    background:#2563eb;
    transform:translateX(5px);
}

/* Main */

.main{
    flex:1;
    padding:30px;
}

/* Header */

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:35px;
}

.header h1{
    font-size:34px;
}

.admin-card{
    background:rgba(255,255,255,.08);
    padding:15px 25px;
    border-radius:20px;
}

/* Stats */

.cards{
    display:grid;
    grid-template-columns:
    repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
}

.card{
    padding:30px;
    border-radius:25px;
    backdrop-filter:blur(15px);
    transition:.4s;
}

.card:hover{
    transform:
    translateY(-10px)
    scale(1.02);
}

.users{
    background:linear-gradient(
        135deg,
        #6366f1,
        #4f46e5);
}

.transactions{
    background:linear-gradient(
        135deg,
        #f59e0b,
        #d97706);
}

.balance{
    background:linear-gradient(
        135deg,
        #10b981,
        #059669);
}

.card h3{
    margin-bottom:15px;
}

.card h1{
    font-size:42px;
}

/* Chart */

.chart-box{
    margin-top:35px;
    background:rgba(255,255,255,.08);
    padding:25px;
    border-radius:25px;
}

/* Bottom Section */

.bottom{
    margin-top:35px;
    display:grid;
    grid-template-columns:2fr 1fr;
    gap:25px;
}

/* Table */

.table-box{
    background:rgba(255,255,255,.08);
    border-radius:25px;
    padding:25px;
}

table{
    width:100%;
    border-collapse:collapse;
}

table th,
table td{
    padding:15px;
    text-align:left;
    border-bottom:
    1px solid rgba(255,255,255,.1);
}

table th{
    color:#38bdf8;
}

/* Quick Actions */

.actions{
    background:rgba(255,255,255,.08);
    padding:25px;
    border-radius:25px;
}

.action-btn{
    display:block;
    text-decoration:none;
    color:white;
    padding:15px;
    margin-bottom:15px;
    border-radius:15px;
    text-align:center;
    transition:.3s;
}

.action-btn:hover{
    transform:translateY(-5px);
}

.blue{
    background:#2563eb;
}

.green{
    background:#10b981;
}

.orange{
    background:#f59e0b;
}

.red{
    background:#ef4444;
}

/* Footer */

.footer{
    margin-top:30px;
    text-align:center;
    color:#94a3b8;
}

/* Mobile */

@media(max-width:900px){

    .wrapper{
        flex-direction:column;
    }

    .sidebar{
        width:100%;
        min-height:auto;
    }

    .bottom{
        grid-template-columns:1fr;
    }
}

</style>
</head>

<body>

<div class="wrapper">

    <!-- Sidebar -->

    <div class="sidebar">

        <div class="logo">
            SecurePAY
        </div>

        <a href="#">Dashboard</a>

        <a href="ViewUsersServlet">
            View Users
        </a>

        <a href="TransactionServlet">
            Transactions
        </a>

        <a href="DeleteUser.jsp">
            Delete User
        </a>
         <a href="AdminLoanServlet" class="quick green">
                <i class="fa-solid fa-building-columns"></i>
                Loan Requests
            </a>

            <a href="RechargeHistoryServlet" class="quick orange">
                <i class="fa-solid fa-mobile-screen-button"></i>
                Recharge History
            </a>
            <a href="NotificationServlet" class="quick blue">
                <i class="fa-solid fa-mobile-screen-button"></i>
                Notification
            </a>
        <a href="AdminLogoutServlet" class="red">
            Logout
        </a>

    </div>

    <!-- Main Content -->

    <div class="main">

        <div class="header">

            <h1>Admin Dashboard</h1>

            <div class="admin-card">
                Administrator
            </div>

        </div>

        <!-- Stats -->

        <div class="cards">

            <div class="card users">
                <h3>Total Users</h3>
                <h1 id="userCount">0</h1>
            </div>

            <div class="card transactions">
                <h3>Total Transactions</h3>
                <h1 id="txnCount">0</h1>
            </div>

            <div class="card balance">
                <h3>Total Balance</h3>
                <h1>
                    ₹<%= totalBalance %>
                </h1>
            </div>

        </div>

        <!-- Chart -->

        <div class="chart-box">

            <h2 style="margin-bottom:20px;">
                System Analytics
            </h2>

            <canvas id="analyticsChart"></canvas>

        </div>

        <!-- Bottom -->

        <div class="bottom">

            <div class="table-box">

                <h2 style="margin-bottom:20px;">
                    Recent Activity
                </h2>

                <table>

                    <tr>
                        <th>User</th>
                        <th>Activity</th>
                        <th>Status</th>
                    </tr>

                    <tr>
                        <td>Rahul</td>
                        <td>Money Transfer</td>
                        <td>Success</td>
                    </tr>

                    <tr>
                        <td>Priya</td>
                        <td>Account Created</td>
                        <td>Success</td>
                    </tr>

                    <tr>
                        <td>Amit</td>
                        <td>Deposit</td>
                        <td>Success</td>
                    </tr>

                </table>

            </div>

            <div class="actions">

                <h2 style="margin-bottom:20px;">
                    Quick Actions
                </h2>

                <a href="ViewUsersServlet"
                   class="action-btn blue">
                    View Users
                </a>

                <a href="ViewTransactionsServlet"
                   class="action-btn green">
                    Transactions
                </a>

                <a href="DeleteUser.jsp"
                   class="action-btn orange">
                    Delete User
                </a>

                <a href="AdminLogoutServlet"
                   class="action-btn red">
                    Logout
                </a>

            </div>

        </div>

        <div class="footer">
            © 2026 SecurePAY Professional Admin Dashboard
        </div>

    </div>

</div>

<script>

function animateValue(id,end){

    let start=0;

    let duration=1500;

    let step=Math.ceil(end/60);

    let counter=setInterval(()=>{

        start+=step;

        if(start>=end){
            start=end;
            clearInterval(counter);
        }

        document.getElementById(id)
        .innerText=start;

    },duration/60);
}

animateValue(
"userCount",
<%= totalUsers %>);

animateValue(
"txnCount",
<%= totalTransactions %>);

const ctx =
document.getElementById(
'analyticsChart');

new Chart(ctx, {

    type:'bar',

    data:{
        labels:[
            'Users',
            'Transactions',
            'Balance'
        ],

        datasets:[{

            label:'SecurePAY Analytics',

            data:[
                <%= totalUsers %>,
                <%= totalTransactions %>,
                <%= (int)(totalBalance/1000) %>
            ]

        }]
    },

    options:{
        responsive:true
    }

});

</script>

</body>
</html>

