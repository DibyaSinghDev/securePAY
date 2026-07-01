<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card p-4 mx-auto"
         style="max-width:400px;">

        <h3 class="text-center">
            Admin Login
        </h3>

        <form action="AdminLoginServlet"
              method="post">

            <input type="text"
                   name="username"
                   class="form-control mb-3"
                   placeholder="Username">

            <input type="password"
                   name="password"
                   class="form-control mb-3"
                   placeholder="Password">

            <button class="btn btn-primary w-100">
                Login
            </button>

        </form>

    </div>

</div>

</body>
</html>