(def failing-grade 40)
(def rounding-window 3)

(defn next-multiple-of [m n]
  "Returns the next number greater than n that's a multiple of m"
  (loop [n n]
    (if (zero? (mod n m))
      n
      (recur (inc n)))))

(defn round [grade]
  "Returns a rounded grade, or original grade if it shouldn't be rounded"
  (let [rounded (next-multiple-of 5 grade)
        within-window? (< (- rounded grade) 3)
        rounded-still-failing? (< rounded failing-grade)]
    (if (and within-window? (not rounded-still-failing?))
      rounded
      grade)))

(defn rounded [grades]
  "Returns rounded grades, in same order original grades are provided"
  (map round grades))

(defn read-grades []
  "Reads grades from *in*"
  (let [n (Integer/parseInt (clojure.string/trim (read-line)))]
    (loop [remaining n
           grades []]
      (if (zero? remaining)
        grades
        (recur
         (dec remaining)
         (conj grades (Integer/parseInt (read-line))))))))

(def result
  (let [grades (read-grades)]
    (rounded grades)))

(let [out-path (get (System/getenv) "OUTPUT_PATH")]
  (spit out-path (clojure.string/join "\n" result) :append true)
  (spit out-path "\n" :append true))
