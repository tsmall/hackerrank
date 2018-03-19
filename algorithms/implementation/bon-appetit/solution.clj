(use '[clojure.string :as str])

(defn parse-line []
  (-> (read-line)
      (str/split #"\s+")
      (->> (map #(Integer/parseInt %)))))

(defn parse-input []
  (let [[_ skipped-item-index] (parse-line)
        item-costs (parse-line)
        [charged-amount] (parse-line)]
    {:skipped-item-index skipped-item-index
     :item-costs item-costs
     :charged-amount charged-amount}))

(defn take-except-at [n coll]
  (let [[before after] (split-at n coll)]
    (concat before (rest after))))

(defn calculate-difference [bill]
  (let [{:keys [skipped-item-index item-costs charged-amount]} bill
        split-items (take-except-at skipped-item-index item-costs)
        expected-amount (/ (apply + split-items) 2)]
    (- charged-amount expected-amount)))

(defn print-difference [d]
  (println
   (if (zero? d)
     "Bon Appetit"
     d)))

(-> (parse-input)
    (calculate-difference)
    (print-difference))
