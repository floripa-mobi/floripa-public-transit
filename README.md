# floripa-public-transit

Ruby gem to fetch public transit information from the [Florianópolis Web Site](http://www.pmf.sc.gov.br/servicos/index.php?pagina=onibus&menu=2).

To fetch information of a specific line:

```ruby
require 'floripa-public-transit'

FloripaPublicTransit.fetch_line '177'
```

Where `177` in the number of the 'Santa Monica' bus line.

## Authors

* [Felipe Munhoz](https://github.com/fnmunhoz)
* [Paulo Ragonha](https://github.com/pirelenito)
