document.addEventListener('DOMContentLoaded', () => {
    // Form submission hander (dummy)
    const form = document.getElementById('contactForm');
    
    if (form) {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            const nome = document.getElementById('nome').value;
            alert(`Obrigado pelo contato, ${nome}! Entraremos em contato em breve.`);
            form.reset();
        });
    }

    // Scroll reveal animation basic logic
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = 1;
                entry.target.style.transform = 'translateY(0)';
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Apply animation initial state and observe cards
    const serviceCards = document.querySelectorAll('.service-card, .impact-item');
    serviceCards.forEach(card => {
        card.style.opacity = 0;
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'all 0.6s ease-out';
        observer.observe(card);
    });
});
