include math

fun pixel-coords(polys :: List) -> List:
    doc: 'turns a list of 2-element tuple into list of points'
    fun pixel-coords-helper(coords):
        point(5 * (180 + coords.{0}), 5 * (90 - coords.{1}))
    end

    polys.map(pixel-coords-helper(_))
end

fun draw-single-polygon(pol :: List) -> Image:
    doc: 'plots a polygon that is overlayed on an empty image'
    x = min(pol.map(_.x))
    y = min(pol.map(_.y))
    overlay-xy(empty-image, x, y, flip-vertical(point-polygon(pol, 'outline', 'gray')))
end

fun draw-country(poly-list :: List) -> Image:
    doc: 'overlays all polygons on a given list, aligning their top left corner'
    cases (List) poly-list:
        |empty => empty-image
        |link(first, rest) => overlay-xy(first, 0, 0, draw-country(rest))
    end
end

fun draw-polygon-outline(polygons :: List) -> Image:
    world = rectangle(1800, 900, 'solid', 'transparent')
    country = draw-country(polygons.map(pixel-coords(_)).map(draw-single-polygon(_)))
    overlay-xy(country, 0, 0, world)
end

fun draw-country-outlines(countries :: Table) -> Image:
    draw-country(countries.get-column('polygons').map(draw-polygon-outline(_)))
end