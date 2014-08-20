{-# LANGUAGE DeriveDataTypeable #-}
module Build.Flags where

import qualified Elm.Internal.Version as Version
import System.Console.CmdArgs (Data, Typeable, (&=), args, def, explicit, help,
                               helpArg, name, summary, typ, typFile, versionArg)

data Flags = Flags
    { make :: Bool
    , files :: [FilePath]
    , set_runtime :: Maybe FilePath
    , get_runtime :: Bool
    , bundle_runtime :: Bool
    , only_js :: Bool
    , print_types :: Bool
    , scripts :: [FilePath]
    , no_prelude :: Bool
    , cache_dir :: FilePath
    , build_dir :: FilePath
    , src_dir :: [FilePath]
    , generate_docs :: Bool
    }
    deriving (Data,Typeable,Show,Eq)

flags :: Flags             
flags = Flags
  { files = def &= args &= typ "FILES"

  , make = False
      &= help "automatically compile dependencies."

  , only_js = False
      &= help "Compile only to JavaScript."

  , no_prelude = False
      &= help "Do not import Prelude by default, used only when compiling standard libraries."

  , scripts = [] &= typFile
      &= help "Load JavaScript files in generated HTML. Files will be included in the given order."

  , set_runtime = Nothing &= typFile
      &= help "Specify a custom location for Elm's runtime system."

  , get_runtime = False
      &= help "Print the absolute path to the default Elm runtime."

  , bundle_runtime = False
      &= help "Bundle the runtime with the generated html or js to create a standalone file."

  , cache_dir = "cache" &= typFile
      &= help "Directory for files cached to make builds faster. Defaults to cache/ directory."

  , build_dir = "build" &= typFile
      &= help "Directory for generated HTML and JS files. Defaults to build/ directory."

  , src_dir = ["."] &= typFile
      &= help "Additional source directories besides project root. Searched when using --make"

  , print_types = False
      &= help "Print out inferred types of top-level definitions."

  , generate_docs = False
      &= help "Generate machine-readable documentation in docs/"
  } &= help "Compile Elm programs to HTML, CSS, and JavaScript."
    &= helpArg [explicit, name "help", name "h"]
    &= versionArg [explicit, name "version", name "v", summary (show Version.elmVersion)]
    &= summary ("The Elm Compiler " ++ show Version.elmVersion ++ ", (c) Evan Czaplicki 2011-2014")
