var openSearchButton = document.getElementById('openSearch');

openSearchButton.addEventListener('click', function(e)
{
    if (e.preventDefault)
    {
        e.preventDefault();
    }
    else
    {
        this.returnValue = false;
    }

    React.render(
        <FullScreenSearchBox />,
        document.getElementById('modalOutlet')
    );
});