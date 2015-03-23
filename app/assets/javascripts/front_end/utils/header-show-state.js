var didScroll,
    lastScrollTop = 0,
    delta = 5,
    navbarHeight = 55;

window.addEventListener('scroll', function()
{
    didScroll = true;
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 150);

function hasScrolled() {
    var st = document.body.scrollTop;

    if(Math.abs(lastScrollTop - st) <= delta)
        return;


    if (st > lastScrollTop && st > navbarHeight){
        document.getElementById('headerContainer').classList.add('scrollDown');
    } else {
        if(st + window.innerHeight < document.body.offsetHeight) {
            document.getElementById('headerContainer').classList.remove('scrollDown');
        }
    }

    lastScrollTop = st;
}