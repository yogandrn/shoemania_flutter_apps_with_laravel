<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Si Paling Ngoding</title>
    <link rel="stylesheet" href="https://sipaling-ngoding.my.id/shoemania/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    {{-- Hero Section  --}}
    <div class="hero" id="home">
        <nav>
            <h2 class="logo">Portfolio</h2>
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About Me</a></li>
                <li><a href="#project">Projects</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            <a href="#" class="btn">Login</a>
        </nav>
        <div class="content">
            <h4>Hello, my name is</h4>
            <h1>Yoga <span>Andrian</span></h1>
            <h3>Mobile Developer</h3>
            <div class="newsletter">
                <form action="">
                    <input type="email" name="email" id="email" placeholder="Enter Your Email">
                    <input type="submit" name="submit" value="Let's Start">
                </form>
            </div>
        </div>
    </div>

    {{-- Section About --}}
    <section class="about" id="about">
        <div class="main">
            <img src="/img/main-img.png" alt="Yoga Andrian">
            <div class="about-text">
                <h2>About Me</h2>
                <h5><span>Mobile Apps</span> Developer</h5>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias hic, voluptatibus ab reprehenderit laboriosam, porro, aliquid iure distinctio dolore exercitationem error minus maxime suscipit a quis omnis! Aut accusamus dignissimos dolor eaque!</p>
                <button type="button">Let's Talk</button>
            </div>
        </div>
    </section>

    {{-- Section Services  --}}
    <div class="service" id="project">
        <div class="title">
            <h2>My Projects</h2>
        </div>

        <div class="box">

            <div class="card">
                <i class="fas fa-bars"></i>
                <h5>Web Development</h5>
                <div class="pra">
                    <p>Lorem ipsum</p>
                    <p style="text-align: center"><a href="#" class="button">Read More</a></p>
                </div>
            </div>
            <div class="card">
                <i class="fas fa-bars"></i>
                <h5>Web Development</h5>
                <div class="pra">
                    <p>Noptio corrupti eligendi.</p>
                    <p style="text-align: center"><a href="#" class="button">Read More</a></p>
                </div>
            </div>
            <div class="card">
                <i class="fas fa-bars"></i>
                <h5>Web Development</h5>
                <div class="pra">
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nesciunt.</p>
                    <p style="text-align: center"><a href="#" class="button">Read More</a></p>
                </div>
            </div>
    </div>

    {{-- Section Contact Me --}}
    <div class="contact-me" id="contact-me">
        <p>Let Me Get You A Useful Apps</p>
        <a href="#" class="button-two">Contact Me</a>
    </div>

    {{-- Footer  --}}
    <footer>
        <p>Yoga Andrian</p>
        <p>For more information, please contact me below</p>
        <div class="social">
            <a href="https://www.facebook.com/yoga.andrian.169405/" target="blank"><i class="fab fa-facebook"></i></a>
            <a href="https://instagram.com/yogandrn_" target="blank"><i class="fab fa-instagram"></i></a>
            <a href="https://www.linkedin.com/in/m-yoga-andrian-putra-50a2211b7/" target="blank"><i class="fa-brands fa-linkedin"></i></a>
        </div>
        <p class="end">&copy; Copyright by Yoga Andrian</p>
    </footer>

</body>
</html>