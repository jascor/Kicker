function openMenu()
{
    document.body.classList.add('menu');
}

function closeMenu()
{
    document.body.classList.remove('menu');
}

var openMenuButton = document.getElementById('openMenu');
openMenuButton.addEventListener('click', openMenu, false);

var menuOverlay = document.getElementById('mainOverlay');
menuOverlay.addEventListener('click', closeMenu, false);

