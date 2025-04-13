const links = [
  //Scott
  'https://signal.me/#eu/gJNSLuZKHvokYlcvqmaZ28SkhovlHEEkjbEJY6hPdcYEOH8xgOhNl516alS-YW4I',
  //Scott
  'https://signal.me/#eu/gJNSLuZKHvokYlcvqmaZ28SkhovlHEEkjbEJY6hPdcYEOH8xgOhNl516alS-YW4I',
  //Scott
  'https://signal.me/#eu/gJNSLuZKHvokYlcvqmaZ28SkhovlHEEkjbEJY6hPdcYEOH8xgOhNl516alS-YW4I',
  //Yogi
  'https://signal.me/#eu/lHbn0I5wB7SxBnVsiYgMJiuU_z9v2sCowJ_QEXJGQGlOKzG0k0NB7qNRhrrEZMXr',
  //Yogi
  'https://signal.me/#eu/lHbn0I5wB7SxBnVsiYgMJiuU_z9v2sCowJ_QEXJGQGlOKzG0k0NB7qNRhrrEZMXr',
  //Yogi
  'https://signal.me/#eu/lHbn0I5wB7SxBnVsiYgMJiuU_z9v2sCowJ_QEXJGQGlOKzG0k0NB7qNRhrrEZMXr',
];

// Randomly select a link from the array
const randomLink = links[Math.floor(Math.random() * links.length)];

// Get the hyperlink element from the page
const linkElement = document.getElementById('random-link');

// Add a click event listener
linkElement.addEventListener('click', function(event) {
    event.preventDefault(); // Prevent the default action of the link
    window.location.href = randomLink; // Redirect to the randomly chosen link
});
