// Mobile Navigation Toggle
document.addEventListener('DOMContentLoaded', function() {
  const mobileBtn = document.createElement('button');
  mobileBtn.className = 'mobile-menu-btn';
  mobileBtn.innerHTML = 'â˜°';
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
