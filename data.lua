-- Entities -----------------------------------------------------------------------------
require("prototypes.entities.oil-gas-separator")
require("prototypes.entities.drilling-equipment.deep-oil-drill")
require("prototypes.entities.drilling-equipment.bore-drill")
require("prototypes.entities.ore-crushers.jaw-crusher")
require("prototypes.entities.ore-screeners.trommel-screener")

require("prototypes.entities.nuclear-refining.injection-recovery-well")

-- Items --------------------------------------------------------------------------------
require("prototypes.items.items")
require("prototypes.items.deep-oil-drill")
require("prototypes.items.bore-drill")
require("prototypes.items.coal")
require("prototypes.items.iron-ores")
require("prototypes.items.copper-ores")

require("prototypes.items.nuclear-refining.injection-recovery-well")

-- Fluids -------------------------------------------------------------------------------
require("prototypes.fluids.drilling-fluid")
require("prototypes.fluids.well-stream")
require("prototypes.fluids.uranium-enriched-solution")

-- Resources ----------------------------------------------------------------------------
require("prototypes.resources.oil-producing.oil-reservoir")

require("prototypes.resources.iron-producing.hematite-ore")
require("prototypes.resources.iron-producing.magnetite-ore")

require("prototypes.resources.copper-producing.copper-oxide-ore")
require("prototypes.resources.copper-producing.copper-sulfide-ore")

require("prototypes.resources.coal-producing.anthracite-coal-ore")
require("prototypes.resources.coal-producing.bituminous-coal-ore")
require("prototypes.resources.coal-producing.lignite-coal-ore")
require("prototypes.resources.coal-producing.peat-ore")

require("prototypes.resources.uranium-producing.uranite-reservoir")

-- Recipes ------------------------------------------------------------------------------
require("prototypes.recipes.recipes")
require("prototypes.recipes.bore-drill")
require("prototypes.recipes.deep-oil-drill")
require("prototypes.recipes.drilling-fluid")
require("prototypes.recipes.oil-gas-separation")
require("prototypes.recipes.ore-crushing")

-- Categories ---------------------------------------------------------------------------
require("prototypes.categories.item-groups.nuclear-refining")
require("prototypes.categories.item-groups.refining")
require("prototypes.categories.fuel")
require("prototypes.categories.recipe")
require("prototypes.categories.resource")