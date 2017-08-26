# Package manager and open-source packages

Using elm-package for installing the open-source modules and creating your own.

## elm-package

You can find elm-package documenataion [here.](https://github.com/elm-lang/elm-package/blob/master/README.md)

In Create Elm App elm-package is available with `elm-app package <command>` command.

### Installing packages

Standard elm-package

```bash
elm-pacakge install <pakage-name>
```

In Create Elm App there's an alias for install command.

```bash
elm-app install <pakage-name>
```

### Diffing 

Check the difference between the different versions of the same package.

```bash
elm-package diff elm-lang/html 1.0.0 2.0.0
```

## elm-search

The wep app is available at [http://klaftertief.github.io/elm-search/](http://klaftertief.github.io/elm-search/)
