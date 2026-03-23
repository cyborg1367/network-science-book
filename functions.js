document.addEventListener("DOMContentLoaded", function() {
  // 1. Inject Progress Bar
  const progressDiv = document.createElement('div');
  progressDiv.id = 'reading-progress';
  document.body.appendChild(progressDiv);

  // 2. Inject Control Buttons
  const controls = document.createElement('div');
  controls.className = 'glass-controls';
  controls.innerHTML = `
    <button onclick="changeFontSize(-1)" title="Smaller">A-</button>
    <button onclick="changeFontSize(1)" title="Larger">A+</button>
    <button onclick="toggleBookmark()" id="btn-bookmark" title="Bookmark This Page">🔖</button>
  `;
  document.body.appendChild(controls);

  // 3. Update Progress Bar on Scroll
  window.onscroll = function() {
    let winScroll = document.body.scrollTop || document.documentElement.scrollTop;
    let height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
    let scrolled = (winScroll / height) * 100;
    document.getElementById("reading-progress").style.width = scrolled + "%";
  };
});

// Font Size Logic
function changeFontSize(delta) {
  const root = document.documentElement;
  const currentSize = parseFloat(getComputedStyle(root).getPropertyValue('--font-size-root')) || 17;
  root.style.setProperty('--font-size-root', (currentSize + delta) + 'px');
}

// Simple Bookmark Logic (Stored in LocalStorage)
function toggleBookmark() {
  const url = window.location.pathname;
  let bookmarks = JSON.parse(localStorage.getItem('book-bookmarks') || '[]');
  
  if (bookmarks.includes(url)) {
    bookmarks = bookmarks.filter(b => b !== url);
    alert("Bookmark removed!");
  } else {
    bookmarks.push(url);
    alert("Page bookmarked!");
  }
  localStorage.setItem('book-bookmarks', JSON.stringify(bookmarks));
}