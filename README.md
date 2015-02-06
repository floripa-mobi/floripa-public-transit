# floripa-public-transit

Ruby gem to fetch public transit information from the [Florianópolis Web Site](http://www.pmf.sc.gov.br/servicos/index.php?pagina=onibus&menu=2).

To fetch information of a specific line:

```ruby
require 'floripa-public-transit'

FloripaPublicTransit.fetch_line '177'
```

Where `177` in the number of the 'Santa Monica' bus line.

## Development

You can use [fig.sh](http://fig.sh/) and [Docker](http://docker.io/).

To run the tests:

```bash
fig run test
```

To build the gem:

```bash
fig run build
```

## Authors

* [Felipe Munhoz](https://github.com/fnmunhoz)
* [Paulo Ragonha](https://github.com/pirelenito)
