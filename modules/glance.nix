{ config, ... }:
{
  services.glance = {
    enable = true;
    settings = {
      server = {
        port = 8080;
      };
      # theme = {
      #   background-color = [0 0 16];
      #   primary-color = [ 43 59 81 ];
      #   positive-color = [ 61 66 44 ];
      #   negative-color = [ 6 96 59 ];
      # };
      pages = [
        {
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "calendar";
                }
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 3;
                  cache = "12h";
                  feeds = [
                    {
                      url = "https://mapuc.substack.com/feed";
                    }
                    {
                      url = "https://aeon.co/feed.rss";
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      type = "hacker-news";
                    }
                    {
                      type = "lobsters";
                    }
                  ];
                }
                {
                  type = "videos";
                  channels = [
                    "UCsBjURrPoezykLs9EqgamOA"
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "reddit";
                      subreddit = "worldnews";
                      show-thumbnails = true;
                    }
                    {
                      type = "reddit";
                      subreddit = "technology";
                      show-thumbnails = true;
                    }

                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "weather";
                  location = "Ithaca, New York, United States";
                  units = "imperial";
                  hour-format = "24h";
                }
                {
                  type = "markets";
                  markets = [
                    {
                      symbol = "SPY";
                      name = "S&P 500";
                    }
                    {
                      symbol = "NVDA";
                      name = "NVIDIA";
                    }
                    {
                      symbol = "AMD";
                      name = "AMD";
                    }
                    {
                      symbol = "MSFT";
                      name = "Microsoft";
                    }
                    {
                      symbol = "INTC";
                      name = "Intel";
                    }
                    {
                      symbol = "TSM";
                      name = "TSMC";
                    }
                    {
                      symbol = "BTC-USD";
                      name = "Bitcoin";
                    }
                  ];
                }
              ];
            }
          ];
          name = "Home";
        }
      ];
    };
  };
}
