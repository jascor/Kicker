var mainVisual = document.querySelector('.defaultView.fullArticle .mainVisual');

if (mainVisual)
{
    var visual = mainVisual.querySelector('img');

    if (visual)
    {
        var visualWidth = visual.clientWidth;

        if (!visualWidth)
        {
            visual.onload = function()
            {
                positionMainVisual(mainVisual, visual);
            }
        }
        else
        {
            positionMainVisual(mainVisual, visual);
        }

        window.addEventListener('resize', _.throttle(function()
        {
            positionMainVisual(mainVisual, visual);
        }, 150));
    }
}

function positionMainVisual(mainVisual, visual)
{
    var caption = mainVisual.querySelector('.caption'),
        visualWidth = visual.clientWidth,
        articleWidth = document.querySelector('.fullArticle').clientWidth;

    /*if (visualWidth !== articleWidth && visualWidth < 770)
    {
        mainVisual.classList.add('right');
    }*/

    if (mainVisual.classList.contains('right') && visualWidth < articleWidth)
    {
        mainVisual.classList.remove('right');
        mainVisual.classList.remove('leftContent');
    }
    else if (visualWidth < articleWidth && visualWidth < 770)
    {
        mainVisual.classList.add('right');
        mainVisual.classList.add('leftContent');
    }
    else
    {
        mainVisual.classList.remove('right');
        mainVisual.classList.remove('leftContent');
    }

    fixCaptionWidth(caption, visualWidth, articleWidth);
}

function fixCaptionWidth(caption, visualWidth, articleWidth)
{
    if (caption.clientWidth > articleWidth)
    {
        caption.style.width = '';

        return false;
    }

    if (caption.clientWidth > visualWidth)
    {
        caption.style.width = visualWidth + 'px';
    }
}

