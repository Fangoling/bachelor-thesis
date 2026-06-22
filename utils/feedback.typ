#let feedback(..args) = {
    let named = args.named()
    counter("feedback").step();
    block(
        breakable: false,
        {
            let f = named.at("feedback", default: "")
            let r = named.at("response", default: "")
            
            if f != "" {
                par(
                    justify: true,
                    [*#context counter("feedback").display(). Feedback: * #f]
                )
            }
            
            if r != "" {
                pad(
                    top: 2mm,
                    left: 5%,
                    bottom: 5mm,
                    par(
                        justify: true,
                        text(
                            fill: blue,
                            [*Response:* #r]
                        )
                    )
                )
            }

            for i in range(2, 10) {
                let fk = "feedback" + str(i)
                let rk = "response" + str(i)
                let fi = named.at(fk, default: "")
                let ri = named.at(rk, default: "")
                
                if fi != "" {
                    pad(
                        top: 2mm,
                        par(
                            justify: true,
                            [*Follow-up Feedback: * #fi]
                        )
                    )
                }
                
                if ri != "" {
                    pad(
                        top: 2mm,
                        left: 5%,
                        bottom: 5mm,
                        par(
                            justify: true,
                            text(
                                fill: blue,
                                [*Response:* #ri]
                            )
                        )
                    )
                }
            }
        }
    )
}
