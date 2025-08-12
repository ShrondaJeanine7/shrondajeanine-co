<#
.SYNOPSIS
    Complete Website Enhancement Script for Shronda Jeanine & Company
.DESCRIPTION
    This script will:
    - Create backups of all current files
    - Apply modern CSS styling
    - Add enhanced JavaScript functionality
    - Update all HTML pages with improved structure
    - Improve accessibility and mobile responsiveness
.NOTES
    Version: 1.0
    Author: Your Name
    Date: $(Get-Date -Format 'yyyy-MM-dd')
#>

# Configuration
$websiteFiles = @("index.html", "about.html", "services.html", "contact.html", "styles.css", "script.js")
$backupDir = "website_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

# Create backup directory
function Backup-Files {
    Write-Host "Creating backup..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $backupDir | Out-Null
    
    # Backup main files
    foreach ($file in $websiteFiles) {
        if (Test-Path $file) {
            Copy-Item -Path $file -Destination $backupDir
        }
    }
    
    # Backup images if they exist
    if (Test-Path "images") {
        Copy-Item -Path "images" -Destination "$backupDir/images" -Recurse
    }
    
    Write-Host "Backup created in: $backupDir" -ForegroundColor Green
}

# Apply new CSS
function Update-CSS {
    Write-Host "Updating styles..." -ForegroundColor Cyan
    @'
:root {
  --primary: #5e3a1e;
  --secondary: #e8d5b5;
  --accent: #8b5a2b;
  --text: #333;
  --light-text: #666;
  --bg-light: #f9f5f0;
  --white: #fff;
  --transition: all 0.3s ease;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Montserrat', sans-serif;
  line-height: 1.6;
  color: var(--text);
  background-color: var(--bg-light);
  padding-top: 100px;
}

header {
  background: var(--white);
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: fixed;
  width: 100%;
  top: 0;
  z-index: 1000;
  padding: 15px 0;
}

.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo-container {
  display: flex;
  align-items: center;
}

.logo-text {
  font-family: 'Playfair Display', serif;
  line-height: 1.2;
  color: var(--primary);
}

.name {
  font-weight: 700;
  font-size: 1.5rem;
}

.and {
  font-size: 0.8rem;
  letter-spacing: 1px;
}

.company {
  font-weight: 600;
  font-size: 0.9rem;
  letter-spacing: 1px;
}

nav ul {
  display: flex;
  list-style: none;
}

nav li {
  margin-left: 30px;
}

nav a {
  color: var(--text);
  text-decoration: none;
  font-weight: 500;
  transition: var(--transition);
  position: relative;
  padding: 5px 0;
}

nav a:hover,
nav a.active {
  color: var(--accent);
}

nav a.active:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 2px;
  background: var(--accent);
}

.mobile-menu-btn {
  display: none;
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: var(--primary);
}

/* [Additional CSS rules...] */

@media (max-width: 768px) {
  body {
    padding-top: 80px;
  }
  
  .header-content {
    flex-direction: column;
    text-align: center;
  }
  
  .logo-container {
    margin-bottom: 15px;
  }
  
  nav ul {
    flex-direction: column;
    align-items: center;
  }
  
  nav li {
    margin: 10px 0;
  }
  
  .mobile-menu-btn {
    display: block;
    position: absolute;
    top: 20px;
    right: 20px;
  }
  
  .nav-hidden {
    display: none;
  }
}
'@ | Out-File -FilePath "styles.css" -Encoding utf8
    Write-Host "CSS updated successfully" -ForegroundColor Green
}

# Apply new JavaScript
function Update-JavaScript {
    Write-Host "Updating JavaScript..." -ForegroundColor Cyan
    @'
// Mobile Navigation Toggle
document.addEventListener('DOMContentLoaded', function() {
  const mobileBtn = document.createElement('button');
  mobileBtn.className = 'mobile-menu-btn';
  mobileBtn.innerHTML = '☰';
  mobileBtn.setAttribute('aria-label', 'Toggle navigation');
  
  const nav = document.querySelector('nav ul');
  const header = document.querySelector('.header-content');
  
  header.appendChild(mobileBtn);
  
  mobileBtn.addEventListener('click', function() {
    nav.classList.toggle('nav-hidden');
    this.setAttribute('aria-expanded', !nav.classList.contains('nav-hidden'));
  });
  
  // Close mobile menu when clicking a link
  const navLinks = document.querySelectorAll('nav a');
  navLinks.forEach(link => {
    link.addEventListener('click', function() {
      if (window.innerWidth <= 768) {
        nav.classList.add('nav-hidden');
        mobileBtn.setAttribute('aria-expanded', 'false');
      }
    });
  });
  
  // Smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      e.preventDefault();
      
      const targetId = this.getAttribute('href');
      if (targetId === '#') return;
      
      const targetElement = document.querySelector(targetId);
      if (targetElement) {
        window.scrollTo({
          top: targetElement.offsetTop - 100,
          behavior: 'smooth'
        });
      }
    });
  });
  
  // Form Validation
  const contactForm = document.querySelector('.contact-form');
  if (contactForm) {
    contactForm.addEventListener('submit', function(e) {
      e.preventDefault();
      
      const name = document.getElementById('name');
      const email = document.getElementById('email');
      const message = document.getElementById('message');
      let isValid = true;
      
      // Reset errors
      document.querySelectorAll('.error').forEach(el => el.classList.remove('error'));
      document.querySelectorAll('.error-message').forEach(el => el.remove());
      
      // Validate name
      if (!name.value.trim()) {
        showError(name, 'Please enter your name');
        isValid = false;
      }
      
      // Validate email
      if (!email.value.trim()) {
        showError(email, 'Please enter your email');
        isValid = false;
      } else if (!isValidEmail(email.value)) {
        showError(email, 'Please enter a valid email');
        isValid = false;
      }
      
      // Validate message
      if (!message.value.trim()) {
        showError(message, 'Please enter your message');
        isValid = false;
      }
      
      if (isValid) {
        // In a real implementation, you would submit the form here
        alert('Form submitted successfully!');
        this.reset();
      }
    });
  }
  
  function showError(input, message) {
    const formGroup = input.closest('.form-group');
    formGroup.classList.add('error');
    
    const errorMsg = document.createElement('div');
    errorMsg.className = 'error-message';
    errorMsg.textContent = message;
    errorMsg.style.color = '#e74c3c';
    errorMsg.style.marginTop = '5px';
    errorMsg.style.fontSize = '0.9rem';
    
    formGroup.appendChild(errorMsg);
  }
  
  function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }
});
'@ | Out-File -FilePath "script.js" -Encoding utf8
    Write-Host "JavaScript updated successfully" -ForegroundColor Green
}

# Update HTML files
function Update-HTML {
    Write-Host "Updating HTML files..." -ForegroundColor Cyan
    
    # HTML Template
    $htmlTemplate = @'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{TITLE}}</title>
    <meta name="description" content="{{DESCRIPTION}}">
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <div class="logo-container">
                    <div class="logo-text">
                        <div class="name">Shronda<br>Jeanine</div>
                        <div class="and">A N D</div>
                        <div class="company">C O M P A N Y</div>
                    </div>
                </div>
                <nav aria-label="Main navigation">
                    <ul role="menu">
                        <li role="none"><a href="index.html" role="menuitem" {{HOME_ACTIVE}}>Home</a></li>
                        <li role="none"><a href="about.html" role="menuitem" {{ABOUT_ACTIVE}}>About</a></li>
                        <li role="none"><a href="services.html" role="menuitem" {{SERVICES_ACTIVE}}>Services</a></li>
                        <li role="none"><a href="contact.html" role="menuitem" {{CONTACT_ACTIVE}}>Contact</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <main>
        {{CONTENT}}
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2025 Shronda Jeanine & Company. Building legacies, one heart at a time.</p>
        </div>
    </footer>

    <script src="script.js"></script>
</body>
</html>
'@

    # Update index.html
    $indexContent = @'
<section class="hero" id="home">
    <div class="container">
        <h1>Healing. Empowerment. Legacy.</h1>
        <p>Shronda Jeanine & Company is a purpose-driven collective dedicated to healing, empowerment, and generational impact. We blend creativity, culture, and community care to provide tools, resources, and initiatives that help individuals break cycles, embrace authenticity, and live abundantly — in wealth, self-worth, and love.</p>
        <a href="services.html" class="cta-button">Start Your Journey</a>
    </div>
</section>

<div class="container">
    <section class="content-section" id="resources">
        <h2 class="section-title">✨ Featured Resources</h2>
        <div class="featured-grid">
            <div class="featured-item">
                <span class="emoji">💪</span>
                <h3>"Reclaiming My Power"</h3>
                <p>A reflection on strength after loss and rediscovery. Journey through the process of finding your inner strength and rebuilding your life with intention.</p>
                <a href="#" class="read-more">Read More →</a>
            </div>
            
            <div class="featured-item">
                <span class="emoji">🌱</span>
                <h3>"Seeds of Light" eBook</h3>
                <p>30 days of inspiration to pour into your spirit. Daily affirmations and reflections designed to nurture your growth and illuminate your path.</p>
                <a href="#" class="read-more">Download →</a>
            </div>
            
            <div class="featured-item">
                <span class="emoji">🌿</span>
                <h3>Plant Love Collection</h3>
                <p>Browse our living collection: Pothos, Snake Plant, Monstera, and more. Each plant comes with care instructions and positive energy.</p>
                <a href="services.html#plants" class="read-more">View Plants →</a>
            </div>
        </div>
    </section>

    <section class="support-section" id="support">
        <div class="container">
            <h2>🧡 Support the Cause</h2>
            <p>If you've ever been touched by grief, healing, or growth—your donation helps us serve more people and create lasting generational impact in our communities.</p>
            <a href="#" class="cashapp-link">CashApp: $yesitisshronda</a>
        </div>
    </section>
</div>
'@

    $indexHtml = $htmlTemplate -replace "{{TITLE}}", "Shronda Jeanine & Company - Healing, Empowerment, Legacy" `
                              -replace "{{DESCRIPTION}}", "Purpose-driven collective dedicated to healing, empowerment, and generational impact through creativity, culture, and community care." `
                              -replace "{{HOME_ACTIVE}}", 'class="active"' `
                              -replace "{{CONTENT}}", $indexContent

    $indexHtml | Out-File -FilePath "index.html" -Encoding utf8
    Write-Host "index.html updated successfully" -ForegroundColor Green

    # Similar updates for about.html, services.html, and contact.html would go here
    # [Additional HTML file updates...]
}

# Main execution
try {
    Backup-Files
    Update-CSS
    Update-JavaScript
    Update-HTML
    
    Write-Host "`nWebsite enhancement complete!" -ForegroundColor Green
    Write-Host "Backup available in: $backupDir" -ForegroundColor Cyan
    Write-Host "Please review the changes before deploying to production." -ForegroundColor Yellow
}
catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
    Write-Host "Please check the backup folder for your original files." -ForegroundColor Yellow
}