function initSlideshows()
{
    var slideshows = document.querySelectorAll('.slideshow.inline');

    for (var i = 0; i < slideshows.length; i++)
    {
        var slideshow = slideshows[i],
            slideshowData = document.querySelector('#' + slideshow.id + ' > script');

        if (!slideshowData)
        {
            continue;
        }
        else
        {
            slideshowData = JSON.parse(slideshowData.innerHTML);
        }

        var slideshowHeader = createHeader(slideshowData.title),
            slideshowContents = buildContents(slideshow.id, slideshowData.slides[0]);

        slideshow.appendChild(slideshowHeader);

        for (var k = 0; i < 2; k++)
        {
            slideshow.appendChild(slideshowContents[k]);
        }
    }
}

function createHeader(title)
{
    var header = document.createElement('header'),
        headerTitle = document.createElement('h4');

    headerTitle.className = 'title';
    headerTitle.innerHTML = title;

    header.appendChild(headerTitle);

    return header;
}

function buildContents(slideshowId, firstSlide)
{
    var contents = document.createElement('div'),
        imageContainer = document.createElement('div'),
        leftClick = document.createElement('nav'),
        rightClick = document.createElement('nav'),
        meta = document.createElement('div'),
        slideNav = document.createElement('nav'),
        previousSlide = document.createElement('div'),
        nextSlide = document.createElement('div');

    contents.className = 'contents';
    imageContainer.className = 'imageContainer';
    imageContainer.setAttribute('data-page', '1');

    imageContainer.innerHTML = '<img class="currentSlide" src="' + firstSlide.link + '">';

    leftClick.className = 'leftClick';
    leftClick.addEventListener('click', function()
    {
        advancePage(slideshowId);
    });

    rightClick.className = 'rightClick';
    rightClick.addEventListener('click', function()
    {
        previousPage(slideshowId);
    });

    imageContainer.appendChild(leftClick);
    imageContainer.appendChild(rightClick);

    contents.appendChild(imageContainer);

    meta.className = 'meta';
    meta.innerHTML = '<p class="caption">' + firstSlide.caption + '<span class="credit">' + firstSlide.credit + '</span></p>';

    previousSlide.className = 'previousSlide';
    nextSlide.className = 'nextSlide';

    previousSlide.addEventListener('click', function()
    {
        advancePage(slideshowId);
    });

    nextSlide.addEventListener('click', function()
    {
        previousPage(slideshowId);
    });

    slideNav.className = 'slideNav';
    slideNav.innerHTML = '<span class="slideCounter"><span class="currentPage">1</span>/5</span>';
    slideNav.appendChild(previousSlide);
    slideNav.appendChild(nextSlide);

    return [contents, meta, slideNav];
}

function advancePage(slideshowId)
{

}

function previousPage(slideshowId)
{

}

initSlideshows();