export def 'past unixepoch' [d: duration] {
    ((date now) - $d | into int) / 1000_000 | math floor
}

export def 'precent' [] {
    ($in * 10000 | math round) / 100
}

export def 'frequency' [-w: int] {
    let o = $in
    '' | fill -c '*' -w ($o * $w | math round)
}

export def 'histogram-column' [column] {
    let o = $in
    let total = $o | get $column | math sum
    $o
    | each {|x|
        let c = $x | get $column | $in / $total
        $x
        | insert precent $"($c | precent)%"
        | insert frequency ($c | frequency -w 40)
    }
}
