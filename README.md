## Weather Obs
--------

### Information

Programming Elixir: OrganizingAProject-6

In the United States, the National Oceanic and Atmospheric Administration provides hourly XML feeds of conditions at 1,800 locations.

For example, the feed for a small airport close to where I’m writing this is at http://w1.weather.gov/xml/current_obs/KDTO.xml.

Write an application that fetches this data, parses it, and displays it in a nice format.

#### generate CLI executable:

```
mix deps.get
mix escript.build

```

#### commandline usage:

```
weather_obs --help # show helps
weather_obs current <station_id>  # show current weather observation information of station_id
weather_obs states # list all states
weather_obs stations <state> # list all stations of given state
```

#### Example:
```
weather_obs current KDTO

weather_obs stations AB
```



